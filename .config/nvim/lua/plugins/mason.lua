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
        exclude = {
          "ts_ls",
          "roslyn",
        },
      },
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        -- "roslyn",
        "pyright",
        "bashls",
        "cssls",
        "emmet_ls",
        "html",
        "jsonls",
        "vuels",
        "tailwindcss",
        "elixirls",
        "rust_analyzer",
        -- "nil_ls",
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
      },
    })
  end,
}
