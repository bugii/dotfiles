vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.clipboard = "unnamedplus"

-- UI =========================================================================
vim.o.breakindent = true -- Indent wrapped lines to match line start
vim.o.cursorline = true -- Enable current line highlighting
vim.o.linebreak = true -- Wrap lines at 'breakat' (if 'wrap' is set)
vim.o.list = true -- Show helpful text indicators
vim.opt.listchars = { extends = "…", nbsp = "␣", precedes = "…", tab = "→ " }
vim.o.pumheight = 10 -- Make popup menu smaller
vim.o.ruler = false -- Don't show cursor coordinates
vim.o.showmode = false -- Don't show mode in command line
vim.o.signcolumn = "yes" -- Always show signcolumn (less flicker)
vim.o.splitbelow = true -- Horizontal splits will be below
vim.o.splitkeep = "screen" -- Reduce scroll during window split
vim.o.splitright = true -- Vertical splits will be to the right
vim.o.winborder = "single" -- Use border in floating windows
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.opt.undofile = true
vim.opt.inccommand = "split"
vim.opt.wrap = true

-- Editing ====================================================================
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.ignorecase = true -- Ignore case during search
vim.opt.smartcase = true
vim.o.incsearch = true -- Show search matches while typing
vim.o.infercase = true -- Infer case in built-in completion
vim.o.shiftwidth = 2 -- Use this number of spaces for indentation
vim.o.smartcase = true -- Respect case if search pattern has upper case
vim.o.autoindent = true -- Use auto indent
vim.o.smartindent = true -- Make indenting smart
vim.o.spelloptions = "camel" -- Treat camelCase word parts as separate words
vim.o.tabstop = 2 -- Show tab as this number of spaces
vim.o.virtualedit = "block" -- Allow going past end of line in blockwise mode

vim.o.cursorlineopt = "screenline,number" -- Show cursor line per screen line

-- Folding ====================================================================
-- Folds (see `:h fold-commands`, `:h zM`, `:h zR`, `:h zA`, `:h zj`)
vim.o.foldlevel = 10 -- Fold nothing by default; set to 0 or 1 to fold
vim.o.foldmethod = "indent" -- Fold based on indent level
vim.o.foldnestmax = 10 -- Limit number of fold levels
vim.o.foldtext = "" -- Show text under fold with its highlighting

require("keymaps")
require("lazy_config")
require("codecompanion-spinner")
