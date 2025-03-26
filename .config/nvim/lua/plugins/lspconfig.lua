return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
    "folke/neodev.nvim",
    "williamboman/mason.nvim",
  },
  config = function()
    require("neodev").setup({
      library = { plugins = { "neotest", "nvim-dap-ui" }, types = true },
    })

    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")

    -- Global mappings.
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Diagnostic: open float" })
    vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "[D]iagnostic: goto [p]rev" })
    vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "[D]iagnostic: goto [n]ext" })

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

    -- To work with folding, we have to manually enable the capabilities
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    mason_lspconfig.setup_handlers({
      -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,

      ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        })
      end,

      ["elixirls"] = function()
        lspconfig.elixirls.setup({
          capabilities = capabilities,
          cmd = {
            require("mason-registry").get_package("elixir-ls"):get_install_path() .. "/language_server.sh",
          },
        })
      end,
    })
  end,
}
