return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "catppuccin",
			},
			tabline = {
				lualine_a = { "branch" },
				lualine_b = { { "filename", path = 1 } },
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},

			-- by unsetting sections and inactive_sessions I can only have lualine as a tabline
			sections = {},
			inactive_sessions = {},
		})
	end,
}
