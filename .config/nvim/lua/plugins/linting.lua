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
