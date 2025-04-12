local wezterm = require("wezterm")
local wswitch = require("workspace-picker")

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
function get_appearance()
  if wezterm.gui then return wezterm.gui.get_appearance() end
  return "Dark"
end

function scheme_for_appearance(appearance)
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
  adjust_window_size_when_changing_font_size = false,
  debug_key_events = false,
  -- enable_tab_bar = false,
  window_decorations = "RESIZE",
  tab_bar_at_bottom = true,
  font = wezterm.font_with_fallback({
    "CommitMono Nerd Font Mono",
  }),
  font_size = 16,
  color_scheme = scheme_for_appearance(get_appearance()),
  colors = {
    background = "#000000",
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

wswitch.apply_to_config(config)

return config
