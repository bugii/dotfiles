return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = false,
				theme = "catppuccin",
				section_separators = "",
				component_separators = "",
				globalstatus = true,
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return str:sub(1, 1)
						end,
					},
				},
				lualine_b = { "branch" },
				lualine_c = { { "filename", path = 1 }, { "diagnostics", sources = { "nvim_lsp" } } },
				lualine_x = { "encoding" },
				lualine_y = {},
				lualine_z = {},
			},

			-- by unsetting sections and inactive_sessions I can only have lualine as a tabline
			-- sections = {},
			-- inactive_sessions = {},
		})
	end,
}
