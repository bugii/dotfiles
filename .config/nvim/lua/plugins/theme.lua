return {
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	--
	-- 	config = function()
	-- 		require("catppuccin").setup({
	-- 			flavour = "macchiato", -- latte, frappe, macchiato, mocha
	-- 			transparent_background = true, -- disables setting the background color.
	-- 			integrations = {
	-- 				cmp = true,
	-- 				gitsigns = true,
	-- 				treesitter = true,
	-- 				noice = true,
	-- 				neotest = true,
	-- 				mason = true,
	-- 				-- which_key = true,
	-- 				-- leap = true,
	-- 				dap = true,
	-- 				dap_ui = true,
	-- 				-- notify = true,
	-- 				-- telescope = {
	-- 				-- 	enabled = true,
	-- 				-- },
	-- 				native_lsp = {
	-- 					enabled = true,
	-- 				},
	-- 				-- indent_blankline = {
	-- 				-- 	enabled = true,
	-- 				-- },
	-- 				-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	-- 			},
	-- 			-- color_overrides = {
	-- 			-- 	mocha = {
	-- 			-- 		base = "#000000",
	-- 			-- 		mantle = "#000000",
	-- 			-- 		crust = "#000000",
	-- 			-- 	},
	-- 			-- },
	-- 			-- highlight_overrides = {
	-- 			-- 	mocha = function(C)
	-- 			-- 		return {
	-- 			-- 			TabLineSel = { bg = C.pink },
	-- 			-- 			CmpBorder = { fg = C.surface2 },
	-- 			-- 			Pmenu = { bg = C.none },
	-- 			-- 		}
	-- 			-- 	end,
	-- 			-- },
	-- 		})
	--
	-- 		-- setup must be called before loading
	-- 		vim.cmd.colorscheme("catppuccin")
	-- 	end,
	-- },

	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				colors = {
					theme = {
						all = {
							ui = {
								bg_gutter = "none",
							},
						},
					},
				},
			})

			-- vim.cmd("colorscheme kanagawa-wave")
			vim.cmd("colorscheme kanagawa-dragon")
			-- vim.cmd("colorscheme kanagawa-lotus")

			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "kanagawa",
				callback = function()
					if vim.o.background == "light" then
						vim.fn.system("kitty +kitten themes Kanagawa_light")
					elseif vim.o.background == "dark" then
						vim.fn.system("kitty +kitten themes Kanagawa_dragon")
					else
						vim.fn.system("kitty +kitten themes Kanagawa")
					end
				end,
			})
		end,
	},

	-- { "folke/tokyonight.nvim", priority = 1000, opts = { style = "storm" } },
}
