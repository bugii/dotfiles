local function apply_theme()
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end

  local palette = dofile(vim.env.HOME .. "/.config/palette.lua").get(vim.o.background)
  vim.g.colors_name = "dedo"

  -- UI Elements
  vim.api.nvim_set_hl(0, "Normal", { fg = palette.fg, bg = palette.bg })
  vim.api.nvim_set_hl(0, "NormalNC", { fg = palette.fg, bg = palette.bg })
  vim.api.nvim_set_hl(0, "Special", { fg = palette.primary })
  vim.api.nvim_set_hl(0, "NormalFloat", { fg = palette.fg, bg = palette.bg })
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = palette.muted, bg = palette.bg })
  vim.api.nvim_set_hl(0, "CursorLine", { bg = palette.surface })
  vim.api.nvim_set_hl(0, "LineNr", { fg = palette.comment })
  vim.api.nvim_set_hl(0, "Visual", { bg = palette.visual })
  vim.api.nvim_set_hl(0, "Search", { fg = palette.bg, bg = palette.info })
  vim.api.nvim_set_hl(0, "IncSearch", { fg = palette.bg, bg = palette.primary })
  vim.api.nvim_set_hl(0, "StatusLine", { fg = palette.fg, bg = palette.bg })
  vim.api.nvim_set_hl(0, "StatusLineNC", { fg = palette.comment, bg = palette.bg })
  vim.api.nvim_set_hl(0, "Pmenu", { fg = palette.fg, bg = palette.bg })
  vim.api.nvim_set_hl(0, "PmenuSel", { fg = palette.fg, bg = palette.visual })
  vim.api.nvim_set_hl(0, "TabLine", { fg = palette.fg, bg = palette.bg })
  vim.api.nvim_set_hl(0, "TabLineSel", { fg = palette.bg, bg = palette.primary })
  vim.api.nvim_set_hl(0, "Title", { fg = palette.primary })
  vim.api.nvim_set_hl(0, "Folded", { fg = palette.comment, bg = palette.visual })
  vim.api.nvim_set_hl(0, "SignColumn", { fg = palette.comment })
  vim.api.nvim_set_hl(0, "ColorColumn", { fg = palette.fg, bg = palette.bg })
  vim.api.nvim_set_hl(0, "Substitute", { fg = palette.fg, bg = palette.secondary })

  -- Syntax
  vim.api.nvim_set_hl(0, "Identifier", { fg = palette.fg })
  vim.api.nvim_set_hl(0, "Comment", { fg = palette.comment })
  vim.api.nvim_set_hl(0, "String", { fg = palette.primary })
  vim.api.nvim_set_hl(0, "Number", { fg = palette.primary })
  vim.api.nvim_set_hl(0, "Function", { fg = palette.secondary, bold = true })
  vim.api.nvim_set_hl(0, "Statement", { fg = palette.muted })
  vim.api.nvim_set_hl(0, "Keyword", { fg = palette.muted, italic = true })
  vim.api.nvim_set_hl(0, "@variable", { fg = palette.fg })
  vim.api.nvim_set_hl(0, "Constant", { fg = palette.secondary })
  vim.api.nvim_set_hl(0, "Operator", { fg = palette.fg })
  vim.api.nvim_set_hl(0, "Type", { fg = palette.fg, bold = true, italic = true })
  vim.api.nvim_set_hl(0, "@tag.attribute.tsx", { fg = palette.fg })
  vim.api.nvim_set_hl(0, "@tag.builtin.tsx", { fg = palette.fg })
  vim.api.nvim_set_hl(0, "@tag.tsx", { fg = palette.fg })
  vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = palette.fg })
  vim.api.nvim_set_hl(0, "@constant.builtin.tsx", { fg = palette.secondary })

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
end

apply_theme()

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function() apply_theme() end,
  desc = "Detect background option change",
})
