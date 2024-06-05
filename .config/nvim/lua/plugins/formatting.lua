return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				python = { "autopep8" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
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
