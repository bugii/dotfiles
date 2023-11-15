return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- set termguicolors to enable highlight groups
		vim.opt.termguicolors = true

		require("nvim-tree").setup()

		vim.keymap.set("n", "<c-n>", ":NvimTreeFindFileToggle<CR>")
	end,
}
