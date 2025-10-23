vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end

vim.g.colors_name = "dedo"

-- NOTE: run this on backgroun change (gets fired initially by TUI)
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    local palette
    if vim.o.background == "dark" then
      palette = {
        bg = "#0B0B0B", -- Rich off-black background
        fg = "#DCDCDC", -- Soft warm white text
        comment = "#5A5A5A", -- Muted grey for comments
        accent = "#1FA39C", -- Vibrant teal accent (keyboard glow inspired)
        muted = "#8C8C8C", -- Secondary/disabled elements
        error = "#C85A3E", -- Warm terracotta red
        warning = "#B96C2E", -- Muted amber/orange
        info = "#3E8CAB", -- Deep blue-cyan for informational highlights
        surface = "#171717", -- Panel background for subtle depth
        visual = "#2A2A2A", -- Selection background, good contrast with fg
        keyword = "#9A9A9A", -- Mid-grey for keywords
        constant = "#66D0C8", -- Cool desaturated cyan for constants
        func = "#E0B567", -- Warm golden yellow for functions
      }
    else
      palette = {
        bg = "#F5F5F3", -- Soft warm off-white background
        fg = "#2C2C2C", -- Dark neutral text for good readability
        comment = "#9A9A9A", -- Muted gray for comments
        accent = "#1FA39C", -- Teal accent, same as dark theme for brand consistency
        muted = "#B6B6B6", -- Light gray for secondary/disabled elements
        error = "#C85A3E", -- Warm terracotta red for errors
        warning = "#D88A45", -- Muted amber for warnings
        info = "#3E8CAB", -- Gentle blue-cyan for informational elements
        surface = "#ECECEA", -- Slightly darker background for panels
        visual = "#DDDCD8", -- Selection highlight, visible but soft
        keyword = "#595959", -- Medium gray for keywords
        constant = "#D9B17E", -- Soft desaturated amber for constants
        func = "#A88438", -- Gentle golden brown for functions
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
  end,
  desc = "Detect background option change",
})
