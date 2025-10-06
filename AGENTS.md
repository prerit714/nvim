# Agent Guidelines for Neovim Configuration

## Build/Test Commands
- **Format code**: `stylua .` (Lua files only)
- **No test suite**: This is a Neovim configuration, no automated tests
- **Check syntax**: Open files in Neovim to validate configuration

## Code Style Guidelines

### Lua Formatting
- Use **2 spaces** for indentation (enforced by .stylua.toml)
- Column width: 160 characters
- Quote style: Auto-prefer double quotes
- Function calls: No parentheses for single string/table arguments

### File Structure
- Plugins in `lua/plugins/` as individual files returning plugin specs
- Core config in `init.lua` with modular loading via `require`
- Templates in `lua/overseer/template/user/` for custom build tasks

### Naming Conventions
- Plugin files: lowercase with hyphens (e.g., `git-signs.lua`)
- Functions: snake_case for global functions, camelCase acceptable for local
- Variables: snake_case preferred

### Code Patterns
- Use `---@diagnostic disable` comments for known LSP warnings
- Plugin specs return tables with lazy.nvim format
- Always provide keybinding descriptions in `desc` field
- Use autogroups for autocmds: `vim.api.nvim_create_augroup()`

This Neovim config uses lazy.nvim for plugin management, LSP with Mason, and conform.nvim for formatting.