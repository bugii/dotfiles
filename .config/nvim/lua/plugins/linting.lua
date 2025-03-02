return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			sql = { "sqlfluff" },
		}

		lint.linters.eslint_d = {
			cmd = function()
				local project_root = vim.fs.root(0, "node_modules")
				vim.env.ESLINT_D_MISS = "fail"
				vim.env.ESLINT_D_ROOT = project_root
				return "eslint_d"
			end,
			args = {
				"--format",
				"json",
				"--config",
				function()
					-- TODO: make it work for all valid config names
					local config = vim.fs.find(
						{ "eslint.config.mjs", "eslint.config.js", "eslint.config.ts" },
						{ upward = true, path = vim.api.nvim_buf_get_name(0), limit = 1 }
					)
					if config and #config > 0 then
						return config[1]
					end
				end,
				"--stdin",
				"--stdin-filename",
				function()
					return vim.api.nvim_buf_get_name(0)
				end,
			},
			stdin = true,
			stream = "both",
			ignore_exitcode = true,
			parser = function(output, bufnr)
				local result = require("lint.linters.eslint").parser(output, bufnr)
				for _, d in ipairs(result) do
					d.source = "eslint_d"
				end
				return result
			end,
		}

		lint.linters.sqlfluff = {
			cmd = "sqlfluff",
			args = {
				"lint",
				"--format=json",
			},
			ignore_exitcode = true,
			stdin = false,
			parser = function(output, _)
				local per_filepath = {}
				if #output > 0 then
					local status, decoded = pcall(vim.json.decode, output)
					if not status then
						per_filepath = {
							{
								filepath = "stdin",
								violations = {
									{
										source = "sqlfluff",
										line_no = 1,
										line_pos = 1,
										code = "jsonparsingerror",
										description = output,
									},
								},
							},
						}
					else
						per_filepath = decoded
					end
				end
				local diagnostics = {}
				for _, i_filepath in ipairs(per_filepath) do
					for _, violation in ipairs(i_filepath.violations) do
						table.insert(diagnostics, {
							source = "sqlfluff",
							lnum = (violation.line_no or violation.start_line_no) - 1,
							col = (violation.line_pos or violation.start_line_pos) - 1,
							severity = vim.diagnostic.severity.ERROR,
							message = violation.description,
							user_data = { lsp = { code = violation.code } },
						})
					end
				end
				return diagnostics
			end,
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
