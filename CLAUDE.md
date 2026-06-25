# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

- **Smoke-check startup**: `nvim --headless -u init.lua +qa`
- **Format Lua**: `stylua .` (uses `.stylua.toml`; StyLua may only be available through Mason inside Neovim, not on the shell PATH)
- No repo-local lint, typecheck, or test commands exist outside Neovim.

## Architecture

`init.lua` is the entrypoint. Load order: `options` → `keymaps` → `lazy-bootstrap` → `lazy-plugins`.

`lua/lazy-plugins.lua` wires everything together — it requires each kickstart plugin spec explicitly, then adds `{ import = "custom.plugins" }` to auto-load all files in `lua/custom/plugins/`.

**Two plugin namespaces:**
- `lua/kickstart/plugins/` — core, upstream-derived plugins (treat as shared infrastructure)
- `lua/custom/plugins/` — personal additions; add new plugins here as individual files

## Key Behaviors and Gotchas

**LSP**: Configured in `lua/kickstart/plugins/lspconfig.lua`. Servers are declared in a `servers` table and auto-installed via Mason. Active servers: `clangd`, `cmake`, `gopls`, `pyrefly`, `rust_analyzer`, `lua_ls`, `glsl_analyzer`, `biome`, `prismals`, `jsonls`. `jsonls` uses `schemastore.nvim` for `$schema` autocompletion and validation. TypeScript uses `typescript-tools.nvim` (in custom plugins), not `ts_ls`.

**Formatting**: conform.nvim triggers on save. Mapped: `lua → stylua`, `java → google-java-format`, `html → biome`, `xml → xmlformatter`, `groovy → npm-groovy-lint` (covers `.gradle` files). HTML via biome only runs in projects whose `biome.json` opts in (`{ "html": { "formatter": { "enabled": true } } }`); otherwise HTML silently isn't formatted. C/C++ format-on-save is explicitly disabled. Slow JVM-based formatters (`groovy`) are listed in the file-scoped `slow_format_filetypes` table in `conform.lua`: they're skipped in the synchronous `format_on_save` and run asynchronously via `format_after_save` instead, so they never hit the 500ms timeout (the table also auto-populates if any other filetype's sync format times out). Manual format: `<leader>f`.

**Linting**: nvim-lint is loaded but all default linters are immediately set to `nil`, so no lint diagnostics fire without editing `lua/kickstart/plugins/lint.lua`.

**Treesitter**: Uses the `main` branch API — calls `require("nvim-treesitter").install(parsers)`, not the legacy `ensure_installed` setup.

**Statusline**: Custom, defined entirely in `options.lua`. Includes a countdown timer accessible via `:TimerStart <1-60>`. The global `vim.g.have_nerd_font` is `false` — all UI symbols must have ASCII fallbacks alongside Nerd Font variants.

**Nerd Font flag**: `vim.g.have_nerd_font = false` in `init.lua`. When adding icons or UI elements, always provide the ASCII/non-Nerd-Font fallback path.

**`lazy-lock.json`**: Generated and managed by lazy.nvim. Do not edit by hand.

## Lua Style

2 spaces, 80 columns, Unix line endings, double quotes preferred, simple statements collapse onto one line. Enforced by `.stylua.toml`.
