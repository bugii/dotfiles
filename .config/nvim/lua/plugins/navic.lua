return {
  "SmiteshP/nvim-navic",
  enabled = false,
  lazy = true,
  config = function()
    local navic = require("nvim-navic")
    local on_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then navic.attach(client, bufnr) end
    end
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        on_attach(client, ev.buf)
      end,
    })
  end,
}
