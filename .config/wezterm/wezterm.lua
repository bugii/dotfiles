local wezterm = require("wezterm")
local wswitch = require("workspace-picker")
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

local light_theme = wezterm.color.load_scheme(os.getenv("HOME") .. "/.config/wezterm/colors/jellybeans-light.toml")
light_theme.background = "#FFFFFF"
local dark_theme = wezterm.color.load_scheme(os.getenv("HOME") .. "/.config/wezterm/colors/jellybeans.toml")
dark_theme.background = "#000000"

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
  if wezterm.gui then return wezterm.gui.get_appearance() end
  return "Dark"
end

local function colors_for_appearance(appearance)
  if appearance:find("Dark") then
    return dark_theme
  else
    return light_theme
  end
end

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
  max_fps = 120,
  font = wezterm.font_with_fallback({
    "JetBrainsMono Nerd Font",
    -- "CommitMono Nerd Font Mono",
    -- "FiraCode Nerd Font Mono",
    -- "FiraMono Nerd Font Mono",
    -- "Monaspace Neon",
    -- "Agave Nerd Font",
  }),
  font_size = 16,
  colors = colors_for_appearance(get_appearance()),
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
      action = wezterm.action.SwitchToWorkspace({
        name = "~/Notes",
        spawn = {
          cwd = wswitch.expandHomePath("~/Notes"),
        },
      }),
    },
    {
      mods = "LEADER",
      key = "d",
      action = wezterm.action.SwitchToWorkspace({
        name = "~/dotfiles",
        spawn = {
          cwd = wswitch.expandHomePath("~/dotfiles"),
        },
      }),
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

wswitch.setup({
  { path = "~/dotfiles" },
  {
    path = "~/Notes",
  },
  {
    path = "/Users/dabu/Projects/mingle",
    tabs = {
      {
        direction = "Right",
        panes = {
          { name = "bla", command = "echo 1" },
          { name = "bla", command = "echo 2" },
          { name = "bla", command = "echo 3" },
        },
      },
    },
  },
  {
    path = "~/Projects/aop.git",
    type = "worktreeroot",
    tabs = {
      { name = "editor" },
      {
        name = "terminals",
        direction = "Bottom",
        panes = {
          { name = "app", command = "cd ./src/app && nvm use && pnpm i" },
          {
            direction = "Right",
            panes = {
              { name = "Api", command = "cd ./src/backend/Aop.Api && dotnet build" },
              { name = "Importer", command = "cd ./src/backend/Aop.DataImport" },
            },
          },
        },
      },
    },
  },
  {
    path = "~/Projects/social",
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
    },
  },
})
wswitch.apply_to_config(config)

tabline.setup({
  options = {
    theme = config.colors,
    theme_overrides = {
      normal_mode = {
        b = { bg = config.colors.background },
        c = { bg = config.colors.background },
        x = { bg = config.colors.background },
        y = { bg = config.colors.background },
      },
      copy_mode = {
        b = { bg = config.colors.background },
        c = { bg = config.colors.background },
        x = { bg = config.colors.background },
        y = { bg = config.colors.background },
      },
      search_mode = {
        b = { bg = config.colors.background },
        c = { bg = config.colors.background },
        x = { bg = config.colors.background },
        y = { bg = config.colors.background },
      },
      window_mode = {
        b = { bg = config.colors.background },
        c = { bg = config.colors.background },
        x = { bg = config.colors.background },
        y = { bg = config.colors.background },
      },
      tab = {
        inactive = { bg = config.colors.background },
      },
    },
    section_separators = {
      left = wezterm.nerdfonts.ple_right_half_circle_thick,
      right = wezterm.nerdfonts.ple_left_half_circle_thick,
    },
    component_separators = {
      left = "",
      right = "",
    },
    tab_separators = {
      left = wezterm.nerdfonts.ple_right_half_circle_thick,
      right = wezterm.nerdfonts.ple_left_half_circle_thick,
    },
  },
  sections = {
    tabline_a = { "mode" },
    tabline_b = { "workspace" },
    tabline_c = { " " },
    tab_active = {
      "index",
      { "parent", padding = 0 },
      "/",
      { "cwd", padding = { left = 0, right = 1 } },
      { "zoomed", padding = 0 },
    },
    tab_inactive = { "index", { "process", padding = { left = 0, right = 1 } } },
    tabline_x = { "ram", "cpu" },
    tabline_y = {},
    tabline_z = { "domain" },
  },
})
tabline.apply_to_config(config)

return config
