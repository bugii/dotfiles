local function apply_theme()
  local palette = dofile(vim.env.HOME .. "/.config/palette.lua").get(vim.o.background)
  vim.g.colors_name = "dedo"

  -- UI Elements
  vim.api.nvim_set_hl(0, "Normal", { fg = palette.fg, bg = palette.bg })
  vim.api.nvim_set_hl(0, "NormalNC", { fg = palette.fg, bg = palette.bg })
  vim.api.nvim_set_hl(0, "WinBar", { fg = palette.fg, bg = palette.bg, bold = true })
  vim.api.nvim_set_hl(0, "WinBarNC", { fg = palette.fg, bg = palette.bg })
  vim.api.nvim_set_hl(0, "Special", { fg = palette.primary })
  vim.api.nvim_set_hl(0, "NormalFloat", { fg = palette.fg, bg = palette.bg })
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = palette.muted, bg = palette.bg })
  vim.api.nvim_set_hl(0, "CursorLine", { bg = palette.surface })
  vim.api.nvim_set_hl(0, "LineNr", { fg = palette.comment })
  vim.api.nvim_set_hl(0, "Visual", { bg = palette.visual })
  vim.api.nvim_set_hl(0, "Search", { fg = palette.bg, bg = palette.tertiary })
  vim.api.nvim_set_hl(0, "IncSearch", { fg = palette.bg, bg = palette.primary })
  vim.api.nvim_set_hl(0, "StatusLine", { fg = palette.fg, bg = palette.bg })
  vim.api.nvim_set_hl(0, "StatusLineNC", { fg = palette.comment, bg = palette.bg })
  vim.api.nvim_set_hl(0, "Pmenu", { fg = palette.fg, bg = palette.bg })
  vim.api.nvim_set_hl(0, "PmenuSel", { fg = palette.fg, bg = palette.visual })
  vim.api.nvim_set_hl(0, "PmenuSbar", { bg = palette.surface })
  vim.api.nvim_set_hl(0, "PmenuThumb", { bg = palette.muted })
  vim.api.nvim_set_hl(0, "TabLine", { fg = palette.fg, bg = palette.bg })
  vim.api.nvim_set_hl(0, "TabLineSel", { fg = palette.bg, bg = palette.primary })
  vim.api.nvim_set_hl(0, "TabLineFill", { fg = palette.bg, bg = palette.bg })
  vim.api.nvim_set_hl(0, "Title", { fg = palette.primary })
  vim.api.nvim_set_hl(0, "Folded", { fg = palette.comment, bg = palette.visual })
  vim.api.nvim_set_hl(0, "SignColumn", { fg = palette.comment })
  vim.api.nvim_set_hl(0, "ColorColumn", { fg = palette.fg, bg = palette.bg })
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = palette.surface, bg = palette.bg })
  vim.api.nvim_set_hl(0, "VertSplit", { fg = palette.surface, bg = palette.bg })
  vim.api.nvim_set_hl(0, "Substitute", { fg = palette.fg, bg = palette.secondary })

  -- Syntax
  vim.api.nvim_set_hl(0, "Identifier", { fg = palette.fg })
  vim.api.nvim_set_hl(0, "Comment", { fg = palette.comment })
  vim.api.nvim_set_hl(0, "String", { fg = palette.tertiary })
  vim.api.nvim_set_hl(0, "Number", { fg = palette.tertiary })
  vim.api.nvim_set_hl(0, "Function", { fg = palette.accent, bold = true })
  vim.api.nvim_set_hl(0, "Statement", { fg = palette.muted })
  vim.api.nvim_set_hl(0, "Keyword", { fg = palette.muted, italic = true })
  vim.api.nvim_set_hl(0, "@variable", { fg = palette.fg })
  vim.api.nvim_set_hl(0, "@variable.parameter", { fg = palette.fg })
  vim.api.nvim_set_hl(0, "@variable.member", { fg = palette.fg })
  vim.api.nvim_set_hl(0, "Constant", { fg = palette.secondary })
  vim.api.nvim_set_hl(0, "Operator", { fg = palette.fg })
  vim.api.nvim_set_hl(0, "Type", { fg = palette.fg, bold = true, italic = true })
  vim.api.nvim_set_hl(0, "@string.escape", { fg = palette.tertiary })
  vim.api.nvim_set_hl(0, "@string.special", { fg = palette.tertiary })
  vim.api.nvim_set_hl(0, "@tag.attribute.tsx", { fg = palette.fg })
  vim.api.nvim_set_hl(0, "@tag.builtin.tsx", { fg = palette.fg })
  vim.api.nvim_set_hl(0, "@tag.tsx", { fg = palette.fg })
  vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = palette.fg })
  vim.api.nvim_set_hl(0, "@constant.builtin.tsx", { link = "Constant" })

  -- LSP semantic tokens (prevent default colorscheme from overriding treesitter)
  vim.api.nvim_set_hl(0, "@lsp.type.function", { link = "Function" })
  vim.api.nvim_set_hl(0, "@lsp.type.method", { link = "Function" })
  vim.api.nvim_set_hl(0, "@lsp.type.variable", { link = "@variable" })
  vim.api.nvim_set_hl(0, "@lsp.type.parameter", { link = "@variable.parameter" })
  vim.api.nvim_set_hl(0, "@lsp.type.property", { link = "@variable.member" })
  vim.api.nvim_set_hl(0, "@lsp.type.keyword", { link = "Keyword" })
  vim.api.nvim_set_hl(0, "@lsp.type.type", { link = "Type" })
  vim.api.nvim_set_hl(0, "@lsp.type.class", { link = "Type" })
  vim.api.nvim_set_hl(0, "@lsp.type.interface", { link = "Type" })
  vim.api.nvim_set_hl(0, "@lsp.type.enum", { link = "Type" })
  vim.api.nvim_set_hl(0, "@lsp.type.enumMember", { link = "Constant" })
  vim.api.nvim_set_hl(0, "@lsp.type.namespace", { link = "Type" })
  vim.api.nvim_set_hl(0, "@lsp.type.string", { link = "String" })
  vim.api.nvim_set_hl(0, "@lsp.type.number", { link = "Number" })
  vim.api.nvim_set_hl(0, "@lsp.type.comment", { link = "Comment" })

  -- Diff (tints derived per-mode so both dark and light look correct)
  local diff_add    = vim.o.background == "dark" and "#1a2e1a" or "#d4edda"
  local diff_change = vim.o.background == "dark" and "#1a2233" or "#d0e4f5"
  local diff_delete = vim.o.background == "dark" and "#2e1a1a" or "#f5d4d0"
  local diff_text   = vim.o.background == "dark" and "#2a3d5c" or "#aacfee"
  vim.api.nvim_set_hl(0, "DiffAdd",    { bg = diff_add })
  vim.api.nvim_set_hl(0, "DiffChange", { bg = diff_change })
  vim.api.nvim_set_hl(0, "DiffDelete", { bg = diff_delete })
  vim.api.nvim_set_hl(0, "DiffText",   { bg = diff_text, bold = true })

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

  -- Mini
  vim.api.nvim_set_hl(0, "MiniHipatternsFixme", { fg = palette.error, bold = true, reverse = true })
  vim.api.nvim_set_hl(0, "MiniHipatternsHack", { fg = palette.secondary, bold = true, reverse = true })
  vim.api.nvim_set_hl(0, "MiniHipatternsTodo", { fg = palette.primary, bold = true, reverse = true })
  vim.api.nvim_set_hl(0, "MiniHipatternsNote", { fg = palette.tertiary, bold = true, reverse = true })
end

apply_theme()

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function() apply_theme() end,
  desc = "Detect background option change",
})
