vim.o.termguicolors = true
-- vim.g.python3_host_prog = "/home/dario/python3nvim"
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
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

require("keymaps")
require("lazy_config")
require("autocmds")
