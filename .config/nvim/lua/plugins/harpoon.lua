return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("harpoon").setup()

		vim.keymap.set("n", "<leader>hm", function()
			require("harpoon.mark").add_file()
		end, { desc = "[H]arpoon [M]ark File" })
		vim.keymap.set("n", "<leader>ht", function()
			require("harpoon.ui").toggle_quick_menu()
		end, { desc = "[H]arpoon [T]oggle Menu" })
	end,
}
