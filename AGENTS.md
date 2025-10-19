# Agent Guidelines for Dotfiles Repository

## Build/Lint/Test Commands
- **Format Lua**: `stylua --config-path stylua.toml .config/nvim/lua/`
- **Lint Lua**: `luacheck .config/nvim/lua/ --config .luarc.json`
- **Lint JS/TS**: `eslint_d --format json --stdin` (via nvim-lint plugin)
- **No build/test commands** - this is a configuration repository

## Code Style Guidelines
- **Language**: Lua (Neovim config), Shell scripts, TOML/JSON configs
- **Formatting**: 2-space indentation, 120 column width, spaces not tabs
- **Naming**: snake_case for Lua variables/functions, kebab-case for config files
- **Imports**: Use `require()` for Lua modules, relative paths preferred
- **Types**: No static typing, rely on Lua LSP diagnostics
- **Error Handling**: Use `assert()` for critical errors, `pcall()` for optional operations
- **Comments**: Minimal comments, descriptive variable names preferred
- **Structure**: Plugin configs return table with lazy.nvim format