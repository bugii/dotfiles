-- Find all lsps supported by mason
-- https://github.com/williamboman/mason-lspconfig.nvim
return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup()

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"tsserver",
				"omnisharp",
				"pyright",
				"bashls",
				"cssls",
				"emmet_ls",
				"html",
				"jsonls",
				"vuels",
				"tailwindcss",
			},
		})

		require("mason-nvim-dap").setup({
			automatic_installation = true,
			ensure_installed = { "js-debug-adapter", "netcoredbg" },
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				-- formatters
				-- prettier is installed on a project level and thus we anyways want to use the project-specific versions
				"stylua",
				"autopep8",
				"csharpier",
				-- linters
				-- eslint is installed on a project level and thus we anyways want to use the project-specific versions
				"pylint",
			},
		})
	end,
}
