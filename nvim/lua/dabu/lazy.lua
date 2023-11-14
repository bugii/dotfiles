local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- Color theme
  {
    "sainnhe/gruvbox-material",
    config = function()
      vim.cmd(
        [[
     " For dark version.
     set background=dark

     " Set contrast.
     " This configuration option should be placed before `colorscheme gruvbox-material`.
     " Available values: 'hard', 'medium'(default), 'soft'
     let g:gruvbox_material_background = 'soft'

     " For better performance
     let g:gruvbox_material_better_performance = 1

     colorscheme gruvbox-material
    ]]
      )
    end
  },

  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      -- disable netrw at the very start of your init.lua (strongly advised)
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- set termguicolors to enable highlight groups
      vim.opt.termguicolors = true

      require('nvim-tree').setup()

      vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>')
    end
  },

  -- Status line at the bottom
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'gruvbox-material',
        },
        sections = {
          lualine_a = {
            {
              'filename',
              path = 1,
            }
          }
        }
      }
    end
  },

  -- Syntax highlighting and co.
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup {
        -- A list of parser names, or "all"
        ensure_installed = {
          'lua',
          'vim',
          'typescript',
          'tsx',
          'html',
          'css',
          'json',
          'json5',
          'markdown',
          'c_sharp'
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      }
    end
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require('cmp');
      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-o>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' }
        }, {
          { name = 'buffer' },
        }),
      })
    end

  },

  -- Show open keybindings
  {
    'folke/which-key.nvim',
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require('which-key').setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Testing
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "marilari88/neotest-vitest",
      "Issafalcon/neotest-dotnet"
    },
    config = function()
      local neotest = require('neotest')

      neotest.setup({
        adapters = {
          require('neotest-vitest'),
          require('neotest-dotnet')({
            discovery_root = "solution"
          })
        },
      })

      vim.keymap.set('n', '<leader>tt', function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Run File" })
      vim.keymap.set('n', "<leader>tT", function() neotest.run.run(vim.loop.cwd()) end, { desc = "Run All Test Files" })
      vim.keymap.set('n', "<leader>tr", function() neotest.run.run() end, { desc = "Run Nearest" })
      vim.keymap.set('n', "<leader>ts", function() neotest.summary.toggle() end, { desc = "Toggle Summary" })
      vim.keymap.set('n', "<leader>to", function() neotest.output.open({ enter = true, auto_close = true }) end,
        { desc = "Show Output" })
      vim.keymap.set('n', "<leader>tO", function() neotest.output_panel.toggle() end, { desc = "Toggle Output Panel" })
      vim.keymap.set('n', "<leader>tS", function() neotest.run.stop() end, { desc = "Stop" })

      vim.keymap.set('n', "<leader>td", function() neotest.run.run({ strategy = "dap" }) end,
        { desc = "Debug Nearest" })
    end
  },

  -- other really handy stuff
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {
        check_ts = true,
        ts_config = {
          lua = { 'string' }, -- it will not add a pair on that treesitter node
          javascript = { 'template_string' },
          java = false,       -- don't check treesitter on java
        }
      }
    end

  },

  'numToStr/Comment.nvim',

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind in [F]iles' })
      vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = '[F]ind [G]it [F]iles' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind in [B]uffers' })
      vim.keymap.set('n', '<leader><leader>', builtin.oldfiles, { desc = 'Find recently opened files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
      vim.keymap.set('n', '<leader>f/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[f/] Fuzzily search in current buffer' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
    end
  },

  -- Pretty stuff
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true,         -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
      })
    end
  },

  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  -- Plugins from subdirectory
  { import = 'dabu.plugins' },
  { import = 'dabu.plugins.lsp' },
}

local opts = {}

require("lazy").setup(plugins, opts)
