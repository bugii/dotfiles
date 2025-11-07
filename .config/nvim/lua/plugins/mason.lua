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
      automatic_enable = true,
      ensure_installed = {
        "lua_ls",
        "vtsls",
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
        -- NOTE: Does not work for now, install manually
        -- "roslyn",
      },
    })

    require("mason-tool-installer").setup({
      ensure_installed = {
        -- formatters
        "prettierd",
        "stylua",
        "black",
        "csharpier",
        -- linters
        "eslint_d",
        "pylint",
        -- lsps
        "roslyn",
      },
    })
  end,
}
