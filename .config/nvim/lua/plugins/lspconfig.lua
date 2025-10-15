return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.diagnostic.config({
      signs = { priority = 9999, severity = { min = "WARN", max = "ERROR" } },
      underline = { severity = { min = "HINT", max = "ERROR" } },
      virtual_lines = false,
      virtual_text = {
        current_line = true,
        severity = { min = "ERROR", max = "ERROR" },
      },
      -- Don't update diagnostics when typing
      update_in_insert = false,
    })

    -- Global mappings.
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Diagnostic: open float" })

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Signature documentation" })
        vim.keymap.set(
          "n",
          "<leader>wa",
          vim.lsp.buf.add_workspace_folder,
          { buffer = ev.buf, desc = "add workspace folder" }
        )
        vim.keymap.set(
          "n",
          "<leader>wr",
          vim.lsp.buf.remove_workspace_folder,
          { buffer = ev.buf, desc = "remove workspace folder" }
        )
        vim.keymap.set(
          "n",
          "<leader>wl",
          function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
          { buffer = ev.buf, desc = "list workspace folders" }
        )
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "type definition" })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "rename" })
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "code action" })
      end,
    })
  end,
}
