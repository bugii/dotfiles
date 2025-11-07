return {
  enabled = false,
  "pmizio/typescript-tools.nvim",
  events = { "VeryLazy" },
  ft = {
    "typescriptreact",
    "javascriptreact",
    "typescript",
    "javascript",
  },
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {},
}
