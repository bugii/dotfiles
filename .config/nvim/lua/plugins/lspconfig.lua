return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"folke/neodev.nvim",
		"williamboman/mason.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("neodev").setup({
			library = { plugins = { "neotest" }, types = true },
		})

		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- Global mappings.
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Diagnostic: open float" })
		vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "[D]iagnostic: goto [p]rev" })
		vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "[D]iagnostic: goto [n]ext" })

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				-- Buffer local mappings.
				vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", { buffer = ev.buf, desc = "references" })
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "go declaration" })
				vim.keymap.set(
					"n",
					"gd",
					"<cmd>Telescope lsp_definitions<CR>",
					{ buffer = ev.buf, desc = "go definition" }
				)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover documentation" })
				vim.keymap.set(
					"n",
					"gi",
					"<cmd>Telescope lsp_implementations<CR>",
					{ buffer = ev.buf, desc = "go implementation" }
				)
				vim.keymap.set(
					"n",
					"gt",
					"<cmd>Telescope lsp_type_definitions<CR>",
					{ buffer = ev.buf, desc = "go type definition" }
				)
				vim.keymap.set(
					"n",
					"<C-k>",
					vim.lsp.buf.signature_help,
					{ buffer = ev.buf, desc = "Signature documentation" }
				)
				vim.keymap.set(
					"n",
					"<leader>wa",
					vim.lsp.buf.add_workspace_folder,
					{ buffer = ev.buf, desc = "add workspace folder" }
				)
				vim.keymap.set(
					"n",
					"<leader>wr",
					vim.lsp.buf.remove_workspace_folder,
					{ buffer = ev.buf, desc = "remove workspace folder" }
				)
				vim.keymap.set("n", "<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, { buffer = ev.buf, desc = "list workspace folders" })
				vim.keymap.set(
					"n",
					"<leader>D",
					vim.lsp.buf.type_definition,
					{ buffer = ev.buf, desc = "type definition" }
				)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "rename" })
				vim.keymap.set(
					{ "n", "v" },
					"<leader>ca",
					vim.lsp.buf.code_action,
					{ buffer = ev.buf, desc = "code action" }
				)
				vim.keymap.set(
					"n",
					"<leader>ds",
					require("telescope.builtin").lsp_document_symbols,
					{ desc = "[D]ocument [S]ymbols" }
				)
				vim.keymap.set(
					"n",
					"<leader>ws",
					require("telescope.builtin").lsp_dynamic_workspace_symbols,
					{ desc = "[W]orkspace [S]ymbols" }
				)
			end,
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()
		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,

			["lua_ls"] = function()
				lspconfig.lua_ls.setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				})
			end,

			["omnisharp"] = function()
				lspconfig.omnisharp.setup({
					cmd = { require("mason-registry").get_package("omnisharp"):get_install_path() .. "/omnisharp" },
					enable_roslyn_analyzers = true,
					capabilities = capabilities,
				})
			end,
		})
	end,
}
