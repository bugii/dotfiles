return {
	"echasnovski/mini.nvim",
	version = "*",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-treesitter/nvim-treesitter-textobjects" },
	config = function()
		require("mini.basics").setup()
		require("mini.bracketed").setup()
		require("mini.pairs").setup()
		require("mini.surround").setup()
		require("mini.indentscope").setup()
		require("mini.visits").setup()
		local MiniAi = require("mini.ai")
		local MiniFiles = require("mini.files")
		local MiniExtra = require("mini.extra")
		local MiniPick = require("mini.pick")
		MiniFiles.setup()
		MiniExtra.setup()
		MiniPick.setup()

		MiniAi.setup({
			custom_textobjects = {
				-- Function definition (needs treesitter queries with these captures)
				m = MiniAi.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
			},
		})

		vim.keymap.set("n", "-", function()
			MiniFiles.open(vim.api.nvim_buf_get_name(0))
		end, { desc = "Open Files" })

		vim.keymap.set("n", "<C-p>", MiniPick.builtin.files, { desc = "Find File" })
		vim.keymap.set("n", "<leader>fg", MiniPick.builtin.grep_live, { desc = "[F]ind by [G]rep" })
		vim.keymap.set("n", "<leader>fh", MiniPick.builtin.help, { desc = "[F]ind [H]elp" })
		vim.keymap.set("n", "<leader>fb", MiniPick.builtin.buffers, { desc = "[F]ind [B]uffers" })

		vim.keymap.set("n", "<leader>fd", MiniExtra.pickers.diagnostic, { desc = "[F]ind [D]iagnostics" })
		vim.keymap.set("n", "<leader>gb", MiniExtra.pickers.git_branches, { desc = "[G]it [B]ranches" })
		vim.keymap.set("n", "<leader>gc", MiniExtra.pickers.git_commits, { desc = "[G]it [C]ommits" })
		vim.keymap.set("n", "<leader>gh", MiniExtra.pickers.git_commits, { desc = "[G]it [H]unks" })
		vim.keymap.set("n", "<leader>fk", MiniExtra.pickers.keymaps, { desc = "[F]ind [K]eymaps" })

		vim.keymap.set("n", "<leader>vr", MiniExtra.pickers.visit_paths, { desc = "[V]isit [R]ecents" })
	end,
}
