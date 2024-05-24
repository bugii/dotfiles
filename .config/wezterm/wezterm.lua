local wezterm = require("wezterm")

return {
	-- general options
	adjust_window_size_when_changing_font_size = false,
	debug_key_events = false,
	enable_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",

	font = wezterm.font_with_fallback({
		"GeistMono Nerd Font",
	}),
	font_size = 16,

	window_padding = {
		left = 0,
		right = 0,
		top = 10,
		bottom = 0,
	},
}
