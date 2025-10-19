vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end

vim.g.colors_name = "doppio"

local palette
if vim.o.background == "dark" then
  palette = {
    bg = "#000000",
    fg = "#E5E5E5",
    comment = "#7A7A7A",
    accent = "#A0522D",
    muted = "#C0C0C0",
    error = "#FF4C4C",
    warning = "#FFB84D",
    info = "#62D6E8",
    surface = "#101010",
    visual = "#222222",
  }
else
  palette = {
    bg = "#FFFFFF",
    fg = "#2A2A2A",
    comment = "#8A8A8A",
    accent = "#A0522D",
    muted = "#B0B0B0",
    error = "#D33A2C",
    warning = "#D4A017",
    info = "#999999",
    surface = "#F4F4F4",
    visual = "#EAEAEA",
  }
end

-- UI Elements
vim.api.nvim_set_hl(0, "Normal", { fg = palette.fg, bg = palette.bg })
vim.api.nvim_set_hl(0, "NormalNC", { fg = palette.fg, bg = palette.bg })
vim.api.nvim_set_hl(0, "NormalFloat", { fg = palette.fg, bg = palette.surface })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = palette.muted, bg = palette.surface })
vim.api.nvim_set_hl(0, "CursorLine", { bg = palette.surface })
vim.api.nvim_set_hl(0, "LineNr", { fg = palette.comment })
vim.api.nvim_set_hl(0, "Visual", { bg = palette.visual })
vim.api.nvim_set_hl(
  0,
  "Search",
  { fg = palette.bg, bg = vim.o.background == "dark" and palette.info or palette.warning }
)
vim.api.nvim_set_hl(
  0,
  "IncSearch",
  { fg = palette.bg, bg = vim.o.background == "dark" and palette.info or palette.warning }
)
vim.api.nvim_set_hl(0, "StatusLine", { fg = palette.fg, bg = palette.surface })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = palette.comment, bg = palette.bg })
vim.api.nvim_set_hl(0, "Pmenu", { fg = palette.fg, bg = palette.surface })
vim.api.nvim_set_hl(0, "PmenuSel", { fg = palette.bg, bg = palette.accent })
vim.api.nvim_set_hl(0, "TabLine", { fg = palette.fg, bg = palette.surface })
vim.api.nvim_set_hl(0, "TabLineSel", { fg = palette.bg, bg = palette.accent })
vim.api.nvim_set_hl(0, "Title", { fg = palette.accent })
vim.api.nvim_set_hl(0, "Comment", { fg = palette.comment })
vim.api.nvim_set_hl(0, "Folded", { fg = palette.comment, bg = palette.visual })
vim.api.nvim_set_hl(0, "SignColumn", { fg = palette.comment })

-- Syntax Groups
vim.api.nvim_set_hl(0, "String", { fg = palette.info })
vim.api.nvim_set_hl(0, "Number", { fg = palette.accent })
vim.api.nvim_set_hl(0, "Function", { fg = palette.accent })
vim.api.nvim_set_hl(0, "Keyword", { fg = palette.accent })
vim.api.nvim_set_hl(0, "Type", { fg = palette.muted })
vim.api.nvim_set_hl(0, "Identifier", { fg = palette.fg })
vim.api.nvim_set_hl(0, "Error", { fg = palette.error })
vim.api.nvim_set_hl(0, "Todo", { fg = palette.warning })

-- Diagnostics
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = palette.error })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = palette.warning })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = palette.info })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = palette.muted })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = palette.error })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = palette.warning })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = palette.info })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = palette.muted })

-- Tree-sitter
vim.api.nvim_set_hl(0, "@comment", { fg = palette.comment })
vim.api.nvim_set_hl(0, "@string", { fg = palette.info })
vim.api.nvim_set_hl(0, "@number", { fg = palette.accent })
vim.api.nvim_set_hl(0, "@function", { fg = palette.accent })
vim.api.nvim_set_hl(0, "@keyword", { fg = palette.accent })
vim.api.nvim_set_hl(0, "@variable", { fg = palette.fg })
vim.api.nvim_set_hl(0, "@type", { fg = palette.muted })
