local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

local M = {}

local is_windows = string.find(wezterm.target_triple, "windows") ~= nil
local user_config = {}

local function expandHomePath(path)
  if path:sub(1, 1) == "~" then
    local home = wezterm.home_dir
    if not home then return nil, "Unable to determine home directory" end
    path = home .. path:sub(2)
  end
  return path, nil
end

-- Run shell command and return output
local function run(cmd)
  local args = { os.getenv("SHELL"), "-c", cmd }
  if is_windows then args = { "cmd", "/c", cmd } end
  local ok, stdout, stderr = wezterm.run_child_process(args)
  if not ok then wezterm.log_error("Failed to run '" .. cmd .. "': " .. stderr) end
  return stdout or ""
end

-- Get static and worktree-based paths
local function get_config_entries()
  -- print(user_config)
  local entries = {}
  for _, entry in ipairs(user_config) do
    if entry.type == "worktreeroot" then
      local output = run("git -C " .. entry.path .. " worktree list --porcelain")
      for line in output:gmatch("[^\r\n]+") do
        if line:match("^worktree ") then
          local path = line:match("^worktree (.+)$")
          if path then
            table.insert(entries, {
              id = path,
              label = wezterm.format({ { Text = "󰊢  " .. path:gsub(wezterm.home_dir, "~") } }),
              type = entry.type,
              tabs = entry.tabs,
            })
          end
        end
      end
    elseif entry.path then
      table.insert(entries, {
        id = entry.path:gsub(wezterm.home_dir, "~"),
        label = wezterm.format({ { Text = "  " .. entry.path:gsub(wezterm.home_dir, "~") } }),
        type = entry.type,
        tabs = entry.tabs,
      })
    end
  end
  return entries
end

-- Get zoxide entries
local function get_zoxide_sessions()
  local sessions = {}
  local output = run("zoxide query -l")
  for line in output:gmatch("[^\r\n]+") do
    table.insert(sessions, {
      id = line:gsub(wezterm.home_dir, "~"),
      label = wezterm.format({ { Text = "  " .. line:gsub(wezterm.home_dir, "~") } }),
      type = "zoxide",
      tabs = nil,
    })
  end
  return sessions
end

-- Get mux workspace names
local function get_existing_workspaces()
  local choices = {}
  for _, name in ipairs(mux.get_workspace_names()) do
    table.insert(choices, {
      id = name,
      label = wezterm.format({ { Text = "  " .. name:gsub(wezterm.home_dir, "~") } }),
      type = "workspace",
      tabs = nil,
    })
  end
  return choices
end

-- Get all session options
local function get_all_choices()
  local all_items = {}
  local seen_ids = {} -- Dictionary to track added IDs

  local function add(items)
    for _, item in ipairs(items) do
      if not seen_ids[item.id] then
        table.insert(all_items, item)
        seen_ids[item.id] = true -- Mark this ID as added
      end
    end
  end

  add(get_existing_workspaces())
  add(get_config_entries())
  add(get_zoxide_sessions())
  return all_items
end

local function generate_fractions(n)
  local fractions = {}
  for i = 2, n do
    table.insert(fractions, 1, (i - 1) / i) -- Insert at the beginning
  end
  return fractions
end

local function create_splits(mux_pane, node)
  -- If the node has no children, it's a leaf node
  if node == nil or not node.panes or #node.panes == 0 then
    if node.command then mux_pane:send_text(node.command .. " \x0D") end
    return
  end

  local fractions = generate_fractions(#node.panes)
  local current_pane = mux_pane
  for i, pane in ipairs(node.panes) do
    if i > 1 then
      current_pane = current_pane:split({ direction = node.direction or "Right", size = fractions[i - 1] })
    end

    -- Recursively process the child node before moving to the next sibling
    create_splits(current_pane, pane)
  end
end

local function create_tabs(win, tabs)
  for i_tab, tab in ipairs(tabs) do
    if i_tab > 1 then win:spawn_tab({ title = tab.name }) end
    local mux_pane = win:tabs()[i_tab]:panes()[1]

    create_splits(mux_pane, tab)
  end
end

local function create_or_switch_to_workspace(item, win, pane)
  if item.type ~= "workspace" then
    local _, _, window = mux.spawn_window({ workspace = item.id, cwd = expandHomePath(item.id) })
    if item.tabs ~= nil then create_tabs(window, item.tabs) end
  end

  -- once all done, change to it
  -- TODO: use better method (mux)
  win:perform_action(
    act.SwitchToWorkspace({ name = item.id, spawn = {
      cwd = expandHomePath(item.id),
    } }),
    pane
  )
end

-- Switch/create workspace
function M.switch_workspace()
  return wezterm.action_callback(function(window, pane)
    local choices = get_all_choices()
    local choices_for_input_selector = {}

    for _, choice in ipairs(choices) do
      table.insert(choices_for_input_selector, { id = choice.id, label = choice.label })
    end

    window:perform_action(
      act.InputSelector({
        title = "Mingle",
        choices = choices_for_input_selector,
        fuzzy = true,
        action = wezterm.action_callback(function(win, p, id)
          if not id then return end

          local selected_item = nil
          for _, choice in ipairs(choices) do
            if choice.id == id then
              selected_item = choice
              break
            end
          end

          create_or_switch_to_workspace(selected_item, win, p)
        end),
      }),
      pane
    )
  end)
end

-- Setup function to accept user configuration
function M.setup(config)
  local default_config = {
    tabs = {},
  }

  local function merge_with_defaults(entry)
    for k, v in pairs(default_config) do
      if entry[k] == nil then entry[k] = v end
    end
    return entry
  end

  user_config = {}
  for _, entry in ipairs(config or {}) do
    if entry.path == nil then
      wezterm.log_error("Invalid configuration: 'path' is required for each entry.")
    else
      table.insert(user_config, merge_with_defaults(entry))
    end
  end
end

-- Keybinding helper
function M.apply_to_config(config)
  config.keys = config.keys or {}
  table.insert(config.keys, {
    key = "f",
    mods = "LEADER",
    action = M.switch_workspace(),
  })
end

M.expandHomePath = expandHomePath

return M
