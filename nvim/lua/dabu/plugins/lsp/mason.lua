-- Find all lsps supported by mason
-- https://github.com/williamboman/mason-lspconfig.nvim

return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    "jay-babu/mason-nvim-dap.nvim"
  },
  config = function()
    require('mason').setup()

    require('mason-lspconfig').setup({
      ensure_installed = { 'lua_ls', 'tsserver', 'omnisharp' }
    })

    require('mason-nvim-dap').setup({
      automatic_installation = true,
      ensure_installed = { 'js-debug-adapter', 'netcoredbg' }
    })
  end
}
