return {
  "SmiteshP/nvim-navic",
  dependencies = { "neovim/nvim-lspconfig" },
  config = function()
    local navic = require("nvim-navic")
    local on_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then navic.attach(client, bufnr) end
    end
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        on_attach(client, ev.buf)
      end,
    })
  end,
}
