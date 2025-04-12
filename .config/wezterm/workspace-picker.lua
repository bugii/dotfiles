local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

local M = {}

local is_windows = string.find(wezterm.target_triple, "windows") ~= nil
local config_file = wezterm.home_dir .. "/.config/wezterm/mingle_config.lua"

-- Run shell command and return output
local function run(cmd)
  local args = { os.getenv("SHELL"), "-c", cmd }
  if is_windows then args = { "cmd", "/c", cmd } end
  local ok, stdout, stderr = wezterm.run_child_process(args)
  if not ok then wezterm.log_error("Failed to run '" .. cmd .. "': " .. stderr) end
  return stdout or ""
end

-- Load config as Lua file
local function load_config()
  local ok, result = pcall(dofile, config_file)
  if not ok then
    wezterm.log_error("Could not load mingle config: " .. result)
    return {}
  end
  return result
end

-- Get static and worktree-based paths
local function get_git_worktrees()
  local entries = {}
  local config = load_config()
  for _, entry in ipairs(config) do
    if entry.type == "worktreeroot" then
      local output = run("git -C " .. entry.path .. " worktree list --porcelain")
      for line in output:gmatch("[^\r\n]+") do
        if line:match("^worktree ") then
          local path = line:match("^worktree (.+)$")
          if path then
            table.insert(entries, {
              id = path,
              label = wezterm.format({ { Text = "󰊢  " .. path:gsub(wezterm.home_dir, "~") } }),
            })
          end
        end
      end
    elseif entry.path then
      table.insert(entries, {
        id = entry.path,
        label = wezterm.format({ { Text = "  " .. entry.path:gsub(wezterm.home_dir, "~") } }),
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
      id = line,
      label = wezterm.format({ { Text = "  " .. line:gsub(wezterm.home_dir, "~") } }),
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
      label = wezterm.format({ { Text = "  " .. name } }),
    })
  end
  return choices
end

-- Get all session options
local function get_all_choices()
  local all = {}
  local seen = {}
  local function add(items)
    for _, item in ipairs(items) do
      if not seen[item.id] then
        seen[item.id] = true
        table.insert(all, item)
      end
    end
  end

  add(get_existing_workspaces())
  add(get_git_worktrees())
  add(get_zoxide_sessions())
  return all
end

-- Switch/create workspace
function M.switch_workspace()
  return wezterm.action_callback(function(window, pane)
    local choices = get_all_choices()

    window:perform_action(
      act.InputSelector({
        title = "Mingle",
        choices = choices,
        fuzzy = true,
        action = wezterm.action_callback(function(win, p, id, label)
          if not id then return end

          for _, ws in ipairs(mux.get_workspace_names()) do
            if ws == id then
              win:perform_action(act.SwitchToWorkspace({ name = id }), p)
              return
            end
          end

          -- Otherwise, treat as a path and create workspace
          win:perform_action(
            act.SwitchToWorkspace({
              name = label,
              spawn = {
                cwd = id,
                label = "Workspace: " .. label,
              },
            }),
            p
          )

          wezterm.emit("workspace.created", mux.get_active_workspace(), id)
          run("zoxide add " .. id)
        end),
      }),
      pane
    )
  end)
end

-- Keybinding helper
function M.apply_to_config(config)
  config.keys = config.keys or {}
  table.insert(config.keys, {
    key = "f",
    mods = "CTRL",
    action = M.switch_workspace(),
  })
end

return M
