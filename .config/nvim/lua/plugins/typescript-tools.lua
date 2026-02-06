-- NOTE: the only reason to use this instead of the new tsgo lsp is that this one still supports plugins,
-- which is the only way I found to get support for styled components support these days...
return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {
    root_dir = function(bufnr, on_dir)
      local root = vim.fs.root(bufnr, { "node_modules", ".git" })
      if not root then root = vim.fn.getcwd() end
      on_dir(root)
    end,
    settings = {
      tsserver_plugins = {
        -- for TypeScript v4.9+
        "@styled/typescript-styled-plugin",
        -- or for older TypeScript versions
        -- "typescript-styled-plugin",
      },
    },
  },
}
