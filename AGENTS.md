# AGENTS.md - Neovim Configuration Guide

## Build/Lint/Test Commands
- **Format Lua code**: `stylua .` (formats all Lua files)
- **Check formatting**: `stylua --check .` (validates formatting without changes)
- **No test suite**: This is a personal Neovim configuration, no unit tests

## Code Style Guidelines
- **Language**: Lua for all configuration files
- **Formatting**: Use StyLua with config in `.stylua.toml` (2 spaces, 160 char width, single quotes)
- **Imports**: Use `require()` for modules, prefer local variables for frequently used modules
- **Comments**: Use `--` for single line, `--[[]]` for multi-line blocks
- **Naming**: snake_case for variables/functions, PascalCase for plugin names
- **Structure**: Main config in `init.lua`, plugins in `lua/` directory
- **Plugin config**: Use lazy.nvim format with `opts = {}` or `config = function()` 
- **Keymaps**: Use descriptive `desc` field, prefer `<leader>` prefix for custom maps
- **Error handling**: Use `pcall()` for optional plugin loading
- **Types**: Use LSP annotations like `---@type` and `---@param` where helpful

## Architecture
- **Base**: Kickstart.nvim configuration structure
- **Plugin manager**: lazy.nvim for all plugin management
- **LSP**: Built-in LSP with mason for language server installation
- **Completion**: blink.cmp with LuaSnip for snippets
- **File structure**: `init.lua` (main), `lua/kickstart/plugins/` (core), `lua/custom/plugins/` (user)