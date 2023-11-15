return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.4",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind in [F]iles" })
		vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "[F]ind [G]it [F]iles" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind in [B]uffers" })
		vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, { desc = "Find recently opened files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
		vim.keymap.set("n", "<leader>f/", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[f/] Fuzzily search in current buffer" })
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
	end,
}
