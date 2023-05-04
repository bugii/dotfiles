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
  -- Startup screen
  { 'goolord/alpha-nvim', dependencies = { 'nvim-web-devicons' } },
  -- Color theme
  "sainnhe/gruvbox-material",
  -- File explorer
  'nvim-tree/nvim-tree.lua',
  'nvim-tree/nvim-web-devicons',
  -- Status line at the bottom
  'nvim-lualine/lualine.nvim',
  -- Syntax highlighting and co.
  'nvim-treesitter/nvim-treesitter',
  -- Autocompletion
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  -- Snippets
  'rafamadriz/friendly-snippets',
  -- Show open keybindings
  {
    'folke/which-key.nvim',
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
  -- other really handy stuff
  'windwp/nvim-autopairs',
  'numToStr/Comment.nvim',
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },
  -- LSP
  {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
  },
  'jose-elias-alvarez/null-ls.nvim',
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
}

local opts = {}

require("lazy").setup(plugins, opts)
