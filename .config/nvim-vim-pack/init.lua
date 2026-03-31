vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.clipboard = "unnamedplus"

-- UI =========================================================================
vim.opt.breakindent = true -- Indent wrapped lines to match line start
vim.opt.cursorline = true -- Enable current line highlighting
vim.opt.linebreak = true -- Wrap lines at 'breakat' (if 'wrap' is set)
vim.opt.list = true -- Show helpful text indicators
vim.opt.listchars = { extends = "…", nbsp = "␣", precedes = "…", tab = "→ " }
vim.opt.pumheight = 10 -- Make popup menu smaller
vim.opt.ruler = false -- Don't show cursor coordinates
vim.opt.showmode = false -- Don't show mode in command line
vim.opt.signcolumn = "yes" -- Always show signcolumn (less flicker)
vim.opt.splitbelow = true -- Horizontal splits will be below
vim.opt.splitkeep = "screen" -- Reduce scroll during window split
vim.opt.splitright = true -- Vertical splits will be to the right
vim.opt.winborder = "single" -- Use border in floating windows
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.opt.undofile = true
vim.opt.inccommand = "split"
vim.opt.wrap = true

-- Editing ====================================================================
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.ignorecase = true -- Ignore case during search
vim.opt.smartcase = true
vim.opt.incsearch = true -- Show search matches while typing
vim.opt.infercase = true -- Infer case in built-in completion
vim.opt.shiftwidth = 2 -- Use this number of spaces for indentation
vim.opt.smartcase = true -- Respect case if search pattern has upper case
vim.opt.autoindent = true -- Use auto indent
vim.opt.smartindent = true -- Make indenting smart
vim.opt.spelloptions = "camel" -- Treat camelCase word parts as separate words
vim.opt.tabstop = 2 -- Show tab as this number of spaces
vim.opt.virtualedit = "block" -- Allow going past end of line in blockwise mode
vim.opt.cursorlineopt = "screenline,number" -- Show cursor line per screen line

-- Folding ====================================================================
-- Folds (see `:h fold-commands`, `:h zM`, `:h zR`, `:h zA`, `:h zj`)
vim.opt.foldlevel = 10 -- Fold nothing by default; set to 0 or 1 to fold
vim.opt.foldmethod = "indent" -- Fold based on indent level
vim.opt.foldnestmax = 10 -- Limit number of fold levels
vim.opt.foldtext = "" -- Show text under fold with its highlighting

--- testing ui2
require("vim._core.ui2").enable({
  enable = true, -- Whether to enable or disable the UI.
  msg = { -- Options related to the message module.
    ---@type 'cmd'|'msg' Default message target, either in the
    ---cmdline or in a separate ephemeral message window.
    ---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
    ---or table mapping |ui-messages| kinds and triggers to a target.
    targets = "cmd",
    cmd = { -- Options related to messages in the cmdline window.
      height = 0.5, -- Maximum height while expanded for messages beyond 'cmdheight'.
    },
    dialog = { -- Options related to dialog window.
      height = 0.5, -- Maximum height.
    },
    msg = { -- Options related to msg window.
      height = 0.5, -- Maximum height.
      timeout = 4000, -- Time a message is visible in the message window.
    },
    pager = { -- Options related to message window.
      height = 1, -- Maximum height.
    },
  },
})

require("theme")
require("lsp")
require("plugins")
require("diagnostics")
require("keymaps")
