return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			sources = {
				{ name = "nvim_lsp" },
				{ name = "buffer" },
				{ name = "path" },
				{ name = "luasnip" },
			},

			mapping = cmp.mapping.preset.insert({
				["<C-l>"] = cmp.mapping.complete(),
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-y>"] = cmp.mapping(
					cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					}),
					{ "i", "c" }
				),
			}),

			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
		})

		cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
			sources = {
				{ name = "vim-dadbod-completion" },
				{ name = "luasnip" },
				{ name = "nvim_lsp" },
				{ name = "buffer" },
			},
		})

		vim.keymap.set({ "i", "s" }, "<c-k>", function()
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			end
		end, { silent = true })

		vim.keymap.set({ "i", "s" }, "<c-j>", function()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { silent = true })
	end,
}
