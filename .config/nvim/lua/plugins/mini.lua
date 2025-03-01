return {
	"echasnovski/mini.nvim",
	version = "*",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-treesitter/nvim-treesitter-textobjects" },
	config = function()
		require("mini.icons").setup()
		require("mini.starter").setup()
		local MiniBasics = require("mini.basics")
		require("mini.bracketed").setup()
		require("mini.pairs").setup()
		require("mini.surround").setup()
		require("mini.indentscope").setup()
		require("mini.statusline").setup()
		require("mini.diff").setup()
		local MiniVisits = require("mini.visits")
		local MiniHipatterns = require("mini.hipatterns")
		local MiniAi = require("mini.ai")
		local MiniFiles = require("mini.files")
		local MiniExtra = require("mini.extra")
		local MiniPick = require("mini.pick")
		MiniFiles.setup()
		MiniExtra.setup()
		MiniPick.setup()
		MiniVisits.setup()

		MiniBasics.setup({
			autocommands = {
				-- highlight on yank is done by glimmer plugin (and i dont really care about the terminal one that's part of the same config option 'basic')
				basic = false,
				relnum_in_visual_mode = true,
			},
		})

		MiniAi.setup({
			search_method = "cover_or_next",
			-- with a smaller value (default is 50...) many times it wont work (even if "cover" would be enough) properly
			n_lines = 500,
			custom_textobjects = {
				-- Function definition (needs treesitter queries with these captures)
				m = MiniAi.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
			},
		})

		MiniHipatterns.setup({
			highlighters = {
				-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
				hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

				-- Highlight hex color strings (`#rrggbb`) using that color
				hex_color = MiniHipatterns.gen_highlighter.hex_color(),
			},
		})

		vim.keymap.set("n", "-", function()
			MiniFiles.open(vim.api.nvim_buf_get_name(0))
		end, { desc = "Open Files" })

		local sort_recent = MiniVisits.gen_sort.default({ recency_weight = 1 })
		vim.keymap.set("n", "L", function()
			MiniVisits.iterate_paths("backward", nil, { sort = sort_recent })
		end, { desc = "Go to last visited path" })

		vim.keymap.set("n", "H", function()
			MiniVisits.iterate_paths("forward", nil, { sort = sort_recent })
		end, { desc = "Go to next visited path" })

		vim.keymap.set("n", "<C-p>", MiniPick.builtin.files, { desc = "Find File" })
		vim.keymap.set("n", "<leader>fg", MiniPick.builtin.grep_live, { desc = "[F]ind by [G]rep" })
		vim.keymap.set("n", "<leader>fh", MiniPick.builtin.help, { desc = "[F]ind [H]elp" })
		vim.keymap.set("n", "<leader>fb", MiniPick.builtin.buffers, { desc = "[F]ind [B]uffers" })

		vim.keymap.set("n", "<leader>fib", MiniExtra.pickers.buf_lines, { desc = "[F]ind [I]n [B]uffers" })
		vim.keymap.set("n", "<leader>fd", MiniExtra.pickers.diagnostic, { desc = "[F]ind [D]iagnostics" })
		vim.keymap.set("n", "<leader>gb", function()
			MiniExtra.pickers.git_branches({ scope = "local" }, {
				source = {
					name = "Git Branches",
					choose = function(item)
						local branch = item:match("%s+(%S+)%s+")
						vim.fn.jobstart({ "git", "switch", branch }, {
							stdout_buffered = true,
							stderr_buffered = true,
							on_stdout = function(_, data)
								print(vim.inspect(data))
							end,
							on_stderr = function(_, data)
								print("failed to check out " .. branch)
								print(vim.inspect(data))
							end,
						})
					end,
				},
			})
		end, { desc = "[G]it [B]ranches" })
		vim.keymap.set("n", "<leader>gc", MiniExtra.pickers.git_commits, { desc = "[G]it [C]ommits" })
		vim.keymap.set("n", "<leader>gh", MiniExtra.pickers.git_commits, { desc = "[G]it [H]unks" })
		vim.keymap.set("n", "<leader>fk", MiniExtra.pickers.keymaps, { desc = "[F]ind [K]eymaps" })

		vim.keymap.set("n", "<leader>vr", function()
			MiniExtra.pickers.visit_paths({ recency_weight = 1 })
		end, { desc = "[V]isit [R]ecents" })
	end,
}
