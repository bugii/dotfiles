vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end

vim.g.colors_name = "dedo"

local palette
if vim.o.background == "dark" then
  palette = {
    bg = "#000000",
    fg = "#F8F8F2",
    comment = "#7A7A7A",
    accent = "#1ABC9C",
    muted = "#C0C0C0",
    error = "#FF4C4C",
    warning = "#FFB84D",
    info = "#62D6E8",
    surface = "#1E1E1E",
    visual = "#222222",
    keyword = "#B8B8B8",
    constant = "#61AFEF",
    string = "#98C379",
    func = "#E5C07B",
  }
else
  palette = {
    bg = "#FFFFFF",
    fg = "#1C1C1C",
    comment = "#8A8A8A",
    accent = "#1ABC9C",
    muted = "#B0B0B0",
    error = "#D33A2C",
    warning = "#D4A017",
    info = "#999999",
    surface = "#F4F4F4",
    visual = "#EAEAEA",
    keyword = "#606060",
    constant = "#3B82F6",
    string = "#10B981",
    func = "#F59E0B",
  }
end

-- UI Elements
vim.api.nvim_set_hl(0, "Normal", { fg = palette.fg, bg = palette.bg })
vim.api.nvim_set_hl(0, "NormalNC", { fg = palette.fg, bg = palette.bg })
vim.api.nvim_set_hl(0, "Special", { fg = palette.accent })
vim.api.nvim_set_hl(0, "NormalFloat", { fg = palette.fg, bg = palette.bg })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = palette.muted, bg = palette.bg })
vim.api.nvim_set_hl(0, "CursorLine", { bg = palette.surface })
vim.api.nvim_set_hl(0, "LineNr", { fg = palette.comment })
vim.api.nvim_set_hl(0, "Visual", { bg = palette.visual })
vim.api.nvim_set_hl(0, "Search", { fg = palette.bg, bg = palette.info })
vim.api.nvim_set_hl(0, "IncSearch", { fg = palette.bg, bg = palette.info })
vim.api.nvim_set_hl(0, "StatusLine", { fg = palette.fg, bg = palette.bg })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = palette.comment, bg = palette.bg })
vim.api.nvim_set_hl(0, "Pmenu", { fg = palette.fg, bg = palette.bg })
vim.api.nvim_set_hl(0, "PmenuSel", { fg = palette.bg, bg = palette.accent })
vim.api.nvim_set_hl(0, "TabLine", { fg = palette.fg, bg = palette.bg })
vim.api.nvim_set_hl(0, "TabLineSel", { fg = palette.bg, bg = palette.accent })
vim.api.nvim_set_hl(0, "Title", { fg = palette.accent })
vim.api.nvim_set_hl(0, "Comment", { fg = palette.comment })
vim.api.nvim_set_hl(0, "Folded", { fg = palette.comment, bg = palette.visual })
vim.api.nvim_set_hl(0, "SignColumn", { fg = palette.comment })
vim.api.nvim_set_hl(0, "ColorColumn", { fg = palette.fg, bg = palette.bg })

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
vim.api.nvim_set_hl(0, "@string", { fg = palette.string })
vim.api.nvim_set_hl(0, "@number", { fg = palette.accent })
vim.api.nvim_set_hl(0, "@function", { fg = palette.func })
vim.api.nvim_set_hl(0, "@function.call", { fg = palette.fg })
vim.api.nvim_set_hl(0, "@function.method", { fg = palette.fg })
vim.api.nvim_set_hl(0, "@keyword", { fg = palette.keyword })
vim.api.nvim_set_hl(0, "@variable", { fg = palette.fg })
vim.api.nvim_set_hl(0, "@constant", { fg = palette.constant })
vim.api.nvim_set_hl(0, "@operator", { fg = palette.fg })
vim.api.nvim_set_hl(0, "@type", { fg = palette.fg })
vim.api.nvim_set_hl(0, "@type.builtin", { fg = palette.fg })
vim.api.nvim_set_hl(0, "@type.definition", { fg = palette.fg })
