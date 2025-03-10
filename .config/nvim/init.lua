vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.clipboard = "unnamedplus"
vim.opt.relativenumber = true
vim.opt.breakindent = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.inccommand = "split"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.wrap = true

require("keymaps")
require("lazy_config")

-- TODO: change to theme in ghostty when changing in nvim (fuzzy match)
-- TODO: tab completion in codepilot does not always seem to work?
-- TODO: shift-H and shift-L act kinda weird? find out why... maybe directories are the problem.. because from there i can't easily go back because it has the same keybind haha
