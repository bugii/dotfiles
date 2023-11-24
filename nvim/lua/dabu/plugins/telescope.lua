return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"ThePrimeagen/git-worktree.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local themes = require("telescope.themes")

		telescope.load_extension("git_worktree")

		telescope.setup({
			pickers = {
				find_files = {
					-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
				},
			},
		})

		vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Find File" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
		vim.keymap.set("n", "<leader>ff", function()
			builtin.current_buffer_fuzzy_find(themes.get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[ff] Fuzzily search in current buffer" })
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
		vim.keymap.set(
			"n",
			"<leader>gw",
			require("telescope").extensions.git_worktree.git_worktrees,
			{ desc = "[G]it [W]orktrees" }
		)
		vim.keymap.set(
			"n",
			"<leader>gw",
			require("telescope").extensions.git_worktree.create_git_worktree,
			{ desc = "[G]it [W]orktrees [C]reate" }
		)

		vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "[G]it [B]ranches" })
		vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "[G]it [C]ommits" })
		vim.keymap.set("n", "<leader>gbc", builtin.git_bcommits, { desc = "[G]it [B]uffer [C]ommits" })
		vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "[G]it [S]tatus" })
	end,
}
