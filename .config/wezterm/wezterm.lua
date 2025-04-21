local wezterm = require("wezterm")
local wswitch = require("workspace-picker")
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
  if wezterm.gui then return wezterm.gui.get_appearance() end
  return "Dark"
end

local function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return "carbonfox"
  else
    return "dayfox"
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
  front_end = "WebGpu",
  adjust_window_size_when_changing_font_size = false,
  window_decorations = "RESIZE",
  font = wezterm.font_with_fallback({
    "CommitMono Nerd Font Mono",
  }),
  font_size = 16,
  color_scheme = scheme_for_appearance(get_appearance()),
  colors = {
    background = get_appearance() == "Dark" and "#000000" or "#FFFFFF",
  },
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
    path = "~/Projects/social-gwt",
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
    },
  },
})
wswitch.apply_to_config(config)

tabline.setup({
  options = {
    theme = get_appearance() == "Light" and "dayfox" or "carbonfox",
    theme_overrides = {
      normal_mode = {
        b = { bg = config.colors.background },
        c = { bg = config.colors.background },
        x = { bg = config.colors.background },
        y = { bg = config.colors.background },
      },
      tab = {
        active = { fg = nil, bg = config.colors.background },
        inactive = { fg = nil, bg = config.colors.background },
        inactive_hover = { fg = nil, bg = config.colors.background },
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
})
tabline.apply_to_config(config)

return config
