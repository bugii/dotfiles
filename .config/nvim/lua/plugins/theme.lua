return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,

		config = function()
			require("catppuccin").setup({
				flavour = "frappe", -- latte, frappe, macchiato, mocha
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					noice = true,
					neotest = true,
					mason = true,
					lsp_trouble = true,
					which_key = true,
					dap = {
						enabled = true,
						enable_ui = true, -- enable nvim-dap-ui
					},
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			})

			-- setup must be called before loading
			vim.cmd.colorscheme("catppuccin")
		end,
	},

	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("kanagawa").setup()
	--
	-- 		-- vim.cmd("colorscheme kanagawa-wave")
	-- 		-- vim.cmd("colorscheme kanagawa-dragon")
	-- 		vim.cmd("colorscheme kanagawa-lotus")
	--
	-- 		vim.api.nvim_create_autocmd("ColorScheme", {
	-- 			pattern = "kanagawa",
	-- 			callback = function()
	-- 				if vim.o.background == "light" then
	-- 					vim.fn.system("kitty +kitten themes Kanagawa_light")
	-- 				elseif vim.o.background == "dark" then
	-- 					vim.fn.system("kitty +kitten themes Kanagawa_dragon")
	-- 				else
	-- 					vim.fn.system("kitty +kitten themes Kanagawa")
	-- 				end
	-- 			end,
	-- 		})
	-- 	end,
	-- },

	-- "folke/tokyonight.nvim",
	-- priority = 1000,
	-- opts = { style = "storm" },
}
