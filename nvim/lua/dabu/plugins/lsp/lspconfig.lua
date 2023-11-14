return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'jose-elias-alvarez/null-ls.nvim',
    'hrsh7th/cmp-nvim-lsp',
    "folke/neodev.nvim",
    {
      "williamboman/mason.nvim",
      opts = {
        ensure_installed = { 'omnisharp' }
      }
    }
  },
  config = function()
    require('neodev').setup({
      library = { plugins = { "neotest" }, types = true },
    })

    local lspconfig = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local null_ls = require('null-ls')


    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Diagnostic: open float' })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Diagnostic: goto prev' })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Diagnostic: goto next' })
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostic: open diagnostics list' })

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = 'go declaration' })
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = 'go definition' })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = 'Hover documentation' })
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = ev.buf, desc = 'go implementation' })
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = ev.buf, desc = 'Signature documentation' })
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
          { buffer = ev.buf, desc = 'add workspace folder' })
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
          { buffer = ev.buf, desc = 'remove workspace folder' })
        vim.keymap.set('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, { buffer = ev.buf, desc = 'list workspace folders' })
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { buffer = ev.buf, desc = 'type definition' })
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = ev.buf, desc = 'rename' })
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = ev.buf, desc = 'code action' })
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = ev.buf, desc = 'references' })
        vim.keymap.set('n', '<leader>f', function()
          vim.lsp.buf.format()
        end, { buffer = ev.buf, desc = 'format buffer' })
        vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols,
          { desc = '[D]ocument [S]ymbols' })
        vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
          { desc = '[W]orkspace [S]ymbols' })
      end,
    })

    lspconfig.bashls.setup {
      capabilities = capabilities,
    }
    lspconfig.cssls.setup {
      capabilities = capabilities,
    }
    lspconfig.emmet_ls.setup {
      capabilities = capabilities,
    }
    lspconfig.html.setup {
      capabilities = capabilities,
    }
    lspconfig.lua_ls.setup {
      capabilities = capabilities,
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace"
          },
          diagnostics = {
            globals = { 'vim' }
          }
        }
      }
    }
    lspconfig.tsserver.setup {
      capabilities = capabilities,
    }
    lspconfig.jsonls.setup {
      capabilities = capabilities,
    }
    lspconfig.vuels.setup {
      capabilities = capabilities,
    }
    lspconfig.tailwindcss.setup {
      capabilities = capabilities,
    }
    lspconfig.omnisharp.setup {
      cmd = { require('mason-registry').get_package("omnisharp"):get_install_path() .. "/omnisharp" },
      enable_roslyn_analyzers = true,
      capabilities = capabilities,
    }


    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
      sources = {
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.formatting.prettierd,
      },
      on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end,
        })
      end
    })
  end
}
