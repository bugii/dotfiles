-- Find all LSPs supported by mason
-- https://github.com/williamboman/mason-lspconfig.nvim
return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  event = "VeryLazy",
  config = function()
    require("mason").setup({
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
    })

    require("mason-lspconfig").setup({
      automatic_enable = {
        exclude = { "mdx_analyzer" },
      },
      ensure_installed = {
        -- "tsgo",
        "lua_ls",
        "pyright",
        "bashls",
        "cssls",
        "emmet_ls",
        "html",
        "jsonls",
        "tailwindcss",
        "rust_analyzer",
        "typos_lsp",
        "yamlls",
        "mdx_analyzer",
        "graphql",
        "eslint",
      },
    })

    require("mason-tool-installer").setup({
      ensure_installed = {
        -- formatters
        "prettierd",
        "stylua",
        -- "black",
        "csharpier",
        -- linters
        -- "eslint_d",
        -- "pylint",
        -- lsps
        -- find all versions here: https://github.com/Crashdummyy/roslynLanguageServer
        -- { "roslyn", version = "5.3.0-2.25571.4" },
        "roslyn",
      },
    })

    vim.lsp.config("mdx_analyzer", {
      init_options = {
        typescript = {
          enabled = true,
        },
      },
    })

    vim.lsp.enable("mdx_analyzer")
  end,
}
