local wezterm = require("wezterm")

return {
	-- OpenGl is lagging like crazy on my debian
	front_end = "WebGpu",
	adjust_window_size_when_changing_font_size = false,
	debug_key_events = false,
	enable_tab_bar = false,
	window_decorations = "RESIZE",

	font = wezterm.font_with_fallback({
		"GeistMono Nerd Font",
	}),
	font_size = 16,
}
