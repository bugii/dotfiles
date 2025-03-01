return {
	"bassamsdata/namu.nvim",
	config = function()
		require("namu").setup({
			-- Enable the modules you want
			namu_symbols = {
				enable = true,
				options = {}, -- here you can configure namu
			},
			colorscheme = {
				enable = true,
				options = {
					-- NOTE: if you activate persist, then please remove any vim.cmd("colorscheme ...") in your config, no needed anymore
					persist = true, -- very efficient mechanism to Remember selected colorscheme
					write_shada = false, -- If you open multiple nvim instances, then probably you need to enable this
				},
			},
		})
		-- === Suggested Keymaps: ===
		vim.keymap.set("n", "<leader>fs", ":Namu symbols<cr>", {
			desc = "[F]ind [S]ymbol",
			silent = true,
		})
		vim.keymap.set("n", "<leader>fc", ":Namu colorscheme<cr>", {
			desc = "[Find] colorscheme",
			silent = true,
		})
	end,
}
