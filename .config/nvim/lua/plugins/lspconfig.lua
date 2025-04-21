return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
    "williamboman/mason.nvim",
  },
  config = function()
    vim.diagnostic.config({
      virtual_lines = { current_line = true },
    })

    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")

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

    mason_lspconfig.setup_handlers({
      -- default handler for installed servers
      function(server_name) lspconfig[server_name].setup({}) end,

      -- typescript language server is setup by typescript-tools plugin
      ["ts_ls"] = function() return end,

      ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
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
          cmd = {
            require("mason-registry").get_package("elixir-ls"):get_install_path() .. "/language_server.sh",
          },
        })
      end,

      ["harper_ls"] = function()
        lspconfig.harper_ls.setup({
          settings = {
            ["harper-ls"] = {
              linters = {
                SentenceCapitalization = false,
                SpellCheck = false,
              },
            },
          },
        })
      end,
    })
  end,
}
