return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			view = { adaptive_size = true },
		})

		vim.keymap.set("n", "<c-n>", ":NvimTreeFindFileToggle<CR>")
	end,
}
