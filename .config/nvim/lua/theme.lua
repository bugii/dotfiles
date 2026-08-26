-- Colorscheme, kept in sync with ~/.config/ghostty/config:
--   light -> GitHub Light Default, dark -> GitHub Dark Default
-- Registered here rather than in plugins.lua because init.lua requires this
-- module first, so the colorscheme is applied before lualine's `theme = "auto"`
-- samples the highlight groups.
vim.pack.add({ "https://github.com/projekt0n/github-nvim-theme" })

-- Neovim detects the terminal background via OSC 11 and sets 'background' after
-- startup. github-nvim-theme ships the two variants as separate colorschemes and
-- has no switching of its own, so map 'background' onto them here.
local applying = false

local function apply_theme()
  if applying then return end -- `:colorscheme` sets 'background', which re-enters
  applying = true
  local scheme = vim.o.background == "light" and "github_light_default" or "github_dark_default"
  pcall(vim.cmd.colorscheme, scheme)
  applying = false
end

apply_theme()

vim.api.nvim_create_autocmd("OptionSet", {
  group = vim.api.nvim_create_augroup("Theme", { clear = true }),
  pattern = "background",
  -- Required: autocmds don't nest by default, so without this the `:colorscheme`
  -- above fires no ColorScheme event and every plugin that re-applies its default
  -- highlights on ColorScheme (blink.cmp, snacks, render-markdown, ...) keeps the
  -- highlights of the previous variant.
  nested = true,
  callback = apply_theme,
  desc = "Follow terminal light/dark appearance",
})
