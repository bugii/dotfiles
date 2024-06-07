return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier", "prettierd" },
				typescript = { { "prettier", "prettierd" } },
				javascriptreact = { { "prettier", "prettierd" } },
				typescriptreact = { { "prettier", "prettierd" } },
				python = { "autopep8" },
				css = { { "prettier", "prettierd" } },
				html = { { "prettier", "prettierd" } },
				json = { { "prettier", "prettierd" } },
				yaml = { { "prettier", "prettierd" } },
				markdown = { { "prettier", "prettierd" } },
				graphql = { { "prettier", "prettierd" } },
				cs = { "csharpier" },
				sql = { "sqlfluff" },
			},
			formatters = {
				sqlfluff = {
					command = "sqlfluff",
					args = { "fix", "-" },
					stdin = true,
					cwd = require("conform.util").root_file({
						".sqlfluff",
					}),
					require_cwd = false,
				},
			},

			format_after_save = {
				lsp_fallback = true,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			conform.format({
				lsp_fallback = true,
				timeout_ms = 500,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
