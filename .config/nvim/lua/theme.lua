vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end

vim.g.colors_name = "dedo"

local palette
if vim.o.background == "dark" then
  palette = {
    bg = "#0D0D0D", -- Soft off-black
    fg = "#E0E0E0", -- Softer white for main text
    comment = "#5C5C5C", -- Darker comment, still readable but recedes more
    accent = "#16A085", -- Primary interactive highlight, strong teal
    muted = "#999999", -- For secondary text, disabled elements
    error = "#E06C75", -- Softer red, still clearly an error
    warning = "#D19A66", -- Muted orange/gold, clear warning
    info = "#56B6C2", -- Cohesive, slightly darker cyan for information
    surface = "#1A1A1A", -- Distinct panel/window background, gives depth
    visual = "#333333", -- Clear selection background, good contrast with fg
    keyword = "#8F8F8F", -- A medium-dark grey for keywords, subtle but distinct
    constant = "#7AE5E0", -- Slightly desaturated cyan, still prominent for constants
    func = "#E5C07B", -- Retains the original golden yellow for functions
  }
else
  palette = {
    bg = "#F8F8F8", -- Soft off-white, less stark than pure white
    fg = "#252525", -- Very dark grey for main text, softer than pure black
    comment = "#A0A0A0", -- Light grey, clearly recedes but readable
    accent = "#1ABC9C", -- Vibrant teal for primary highlights
    muted = "#C0C0C0", -- Even lighter grey for truly muted/disabled elements
    error = "#CC3333", -- Clear, strong red for errors
    warning = "#D79921", -- Rich, golden orange for warnings
    info = "#6EA8C0", -- A soft, muted blue for informational messages
    surface = "#EDEDED", -- Distinct panel/window background, gives depth
    visual = "#E0E6F0", -- Soft, light blue-grey for selections, clearly visible
    keyword = "#707070", -- Medium-light grey for keywords, subtle but distinct
    constant = "#208080", -- Darker, rich teal/cyan for constants, pops effectively
    func = "#C67840", -- More earthy, muted orange/brown for functions, less jarring
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
vim.api.nvim_set_hl(0, "IncSearch", { fg = palette.bg, bg = palette.accent })
vim.api.nvim_set_hl(0, "StatusLine", { fg = palette.fg, bg = palette.bg })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = palette.comment, bg = palette.bg })
vim.api.nvim_set_hl(0, "Pmenu", { fg = palette.fg, bg = palette.bg })
vim.api.nvim_set_hl(0, "PmenuSel", { fg = palette.bg, bg = palette.accent })
vim.api.nvim_set_hl(0, "TabLine", { fg = palette.fg, bg = palette.bg })
vim.api.nvim_set_hl(0, "TabLineSel", { fg = palette.bg, bg = palette.accent })
vim.api.nvim_set_hl(0, "Title", { fg = palette.accent })
vim.api.nvim_set_hl(0, "Folded", { fg = palette.comment, bg = palette.visual })
vim.api.nvim_set_hl(0, "SignColumn", { fg = palette.comment })
vim.api.nvim_set_hl(0, "ColorColumn", { fg = palette.fg, bg = palette.bg })
vim.api.nvim_set_hl(0, "Substitute", { fg = palette.fg, bg = palette.accent })

-- Syntax
vim.api.nvim_set_hl(0, "Identifier", { fg = palette.constant })
vim.api.nvim_set_hl(0, "Comment", { fg = palette.comment })
vim.api.nvim_set_hl(0, "String", { fg = palette.accent })
vim.api.nvim_set_hl(0, "Number", { fg = palette.accent })
vim.api.nvim_set_hl(0, "Function", { fg = palette.func })
vim.api.nvim_set_hl(0, "Statement", { fg = palette.keyword })
vim.api.nvim_set_hl(0, "Keyword", { fg = palette.keyword, italic = true })
vim.api.nvim_set_hl(0, "@variable", { fg = palette.fg })
vim.api.nvim_set_hl(0, "Constant", { fg = palette.constant })
vim.api.nvim_set_hl(0, "Operator", { fg = palette.fg })
vim.api.nvim_set_hl(0, "Type", { fg = palette.constant })
vim.api.nvim_set_hl(0, "@tag.attribute.tsx", { fg = palette.fg })
vim.api.nvim_set_hl(0, "@tag.builtin.tsx", { fg = palette.fg })
vim.api.nvim_set_hl(0, "@tag.tsx", { fg = palette.fg })
vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = palette.fg })
vim.api.nvim_set_hl(0, "@constant.builtin.tsx", { fg = palette.constant })

-- Diagnostics
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = palette.error })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = palette.warning })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = palette.info })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = palette.muted })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = palette.error })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = palette.warning })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = palette.info })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = palette.muted })

-- Plugins =========================================================================
-- Render markdown
vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { link = "RenderMarkdownH1" })
vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { link = "RenderMarkdownH2" })
vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { link = "RenderMarkdownH3" })
vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { link = "RenderMarkdownH4" })
vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { link = "RenderMarkdownH5" })
vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { link = "RenderMarkdownH6" })
vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = palette.bg })
