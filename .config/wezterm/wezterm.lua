local wezterm = require("wezterm")
local workspace_picker = wezterm.plugin.require("https://github.com/bugii/workspace-picker-plugin")
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
  if wezterm.gui then return wezterm.gui.get_appearance() end
  return "Dark"
end

local appearance_mode = get_appearance() == "Dark" and "dark" or "light"
local palette_module = dofile(os.getenv("HOME") .. "/.config/palette.lua")
local palette = palette_module.get(appearance_mode)
local surface_color = palette.surface
local colors = {
  foreground = palette.fg,
  background = palette.bg,
  cursor_bg = palette.fg,
  cursor_fg = palette.bg,
  cursor_border = palette.fg,
  selection_fg = palette.fg,
  selection_bg = palette.visual,
  scrollbar_thumb = palette.surface,
  split = palette.surface,
  ansi = {
    palette.primary,
    palette.secondary,
    palette.tertiary,
    palette.info,
    palette.warning,
    palette.secondary,
    palette.primary,
    palette.warning,
  },
  brights = {
    -- autocomplete
    palette.muted,
    -- git changes
    palette.fg,
    palette.primary,
    -- command runtime
    palette.fg,
    palette.info,
    -- branch
    palette.primary,
    -- file path?
    palette.tertiary,
    palette.secondary,
  },
}
-- if you are *NOT* lazy-loading smart-splits.nvim (recommended)
local function is_vim(pane)
  -- this is set by the plugin, and unset on ExitPre in Neovim
  return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
  h = "Left",
  j = "Down",
  k = "Up",
  l = "Right",
}

local function split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == "resize" and "META" or "CTRL",
    action = wezterm.action_callback(function(win, pane)
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
        }, pane)
      else
        if resize_or_move == "resize" then
          win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end
    end),
  }
end

local config = {
  send_composed_key_when_left_alt_is_pressed = true,
  send_composed_key_when_right_alt_is_pressed = true,
  max_fps = 120,
  font = wezterm.font_with_fallback({
    "CommitMono Nerd Font",
    "JetBrainsMono Nerd Font",
    "0xProto Nerd Font",
    "FiraCode Nerd Font Mono",
  }),
  font_size = 16,
  colors = colors,
  leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
  keys = {
    -- splitting
    {
      mods = "LEADER",
      key = "-",
      action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
      mods = "LEADER",
      key = "=",
      action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
      mods = "LEADER",
      key = "m",
      action = wezterm.action.TogglePaneZoomState,
    },
    {
      mods = "LEADER",
      key = "0",
      action = wezterm.action.PaneSelect({
        mode = "SwapWithActive",
      }),
    },
    {
      mods = "LEADER",
      key = "n",
      action = workspace_picker.switch_to_workspace("~/Notes"),
    },
    {
      mods = "LEADER",
      key = "d",
      action = workspace_picker.switch_to_workspace("~/dotfiles"),
    },
    -- activate copy mode or vim mode
    {
      key = "Enter",
      mods = "LEADER",
      action = wezterm.action.ActivateCopyMode,
    },

    -- move between split panes
    split_nav("move", "h"),
    split_nav("move", "j"),
    split_nav("move", "k"),
    split_nav("move", "l"),
    -- resize panes
    split_nav("resize", "h"),
    split_nav("resize", "j"),
    split_nav("resize", "k"),
    split_nav("resize", "l"),
  },
}

workspace_picker.setup({
  {
    path = "~/dotfiles",
    tabs = {
      {
        name = "editor",
        direction = "Bottom",
        panes = { { name = "vim", command = "vim" } },
      },
      { name = "ai", panes = { { name = "opencode", command = "opencode" } } },
    },
  },
  { path = "~/Notes" },
  -- {
  --   path = "~/Projects/aop.git",
  --   type = "worktreeroot",
  --   tabs = {
  --     { name = "editor" },
  --     {
  --       name = "terminals",
  --       direction = "Bottom",
  --       panes = {
  --         { name = "app", command = "cd ./src/app && nvm use && pnpm i" },
  --         {
  --           direction = "Right",
  --           panes = {
  --             { name = "Api",      command = "cd ./src/backend/Aop.Api && dotnet build" },
  --             { name = "Importer", command = "cd ./src/backend/Aop.DataImport" },
  --           },
  --         },
  --       },
  --     },
  --     { name = "ai",    command = "opencode" },
  --   },
  -- },
  {
    path = "~/Projects/vellu",
    type = "worktreeroot",
    tabs = {
      {
        name = "root",
        direction = "Bottom", -- Split vertically
        panes = {
          {
            name = "editor",
            command = "vim",
          },
          {
            direction = "Right",
            panes = {
              { name = "terminal" },
              { name = "term2" },
            },
          },
        },
      },
      { name = "ai", command = "opencode" },
    },
  },
  {
    path = "~/Projects/workspace-picker-plugin/",
    tabs = {
      {
        { name = "editor", panes = { { name = "editor", command = "vim" } } },
        { name = "ai", panes = { { name = "opencode", command = "opencode" } } },
      },
    },
  },
  {
    path = "~/Projects/DG/isomorph.git/",
    type = "worktreeroot",
    tabs = {
      { name = "editor" },
      {
        name = "terminals",
        direction = "Right",
        panes = {
          { name = "app", command = "yarn" },
          { name = "other" },
        },
      },
      { name = "ai", command = "opencode" },
    },
  },
  {
    path = "~/Projects/DG/devinite.git/",
    type = "worktreeroot",
    tabs = {
      { name = "editor" },
      {
        name = "terminals",
        direction = "Right",
        panes = {
          { name = "app" },
          { name = "other" },
        },
      },
      { name = "ai", command = "opencode" },
    },
  },
  {
    path = "~/Projects/DG/Dg.Community.git/",
    type = "worktreeroot",
    tabs = {
      { name = "editor" },
      {
        name = "terminals",
        direction = "Right",
        panes = {
          { name = "app" },
          { name = "other" },
        },
      },
      { name = "ai", command = "opencode" },
    },
  },
})
workspace_picker.apply_to_config(config)

tabline.setup({
  options = {
    theme = config.colors,
    section_separators = "",
    component_separators = "",
    tab_separators = "",
    theme_overrides = {
      normal_mode = {
        a = { fg = config.colors.foreground, bg = config.colors.background },
        b = { fg = config.colors.foreground, bg = config.colors.background },
      },
      copy_mode = {
        a = { fg = config.colors.foreground, bg = config.colors.background },
        b = { fg = config.colors.foreground, bg = config.colors.background },
      },
      search_mode = {
        a = { fg = config.colors.foreground, bg = config.colors.background },
        b = { fg = config.colors.foreground, bg = config.colors.background },
      },
      window_mode = {
        a = { fg = config.colors.foreground, bg = config.colors.background },
        b = { fg = config.colors.foreground, bg = config.colors.background },
      },
      tab = {
        active = { fg = config.colors.foreground, bg = surface_color },
        inactive = { fg = config.colors.foreground, bg = config.colors.background },
        inactive_hover = { fg = config.colors.foreground, bg = config.colors.background },
      },
    },
  },
  sections = {
    tabline_a = { "mode" },
    tabline_b = { "workspace" },
    tabline_c = { " " },
    tab_active = {
      "index",
      { "process", padding = { left = 0, right = 1 } },
      -- "tab",
      { "zoomed", padding = 0 },
    },
    tab_inactive = {
      "index",
      { "process", padding = { left = 0, right = 1 } },
      -- "tab",
      { "zoomed", padding = 0 },
    },
    tabline_x = {},
    tabline_y = {},
    tabline_z = { "domain" },
  },
})
tabline.apply_to_config(config)

return config
