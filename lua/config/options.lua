-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Neovide setup
if vim.g.neovide then
  vim.keymap.set({ "n", "v" }, "<C-+>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
  vim.keymap.set({ "n", "v" }, "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
  vim.keymap.set({ "n", "v" }, "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>")
end

-- Setting my preferred keybinds for insert mode
vim.keymap.set("i", "jk", "<Esc>", {
  silent = true,
})

vim.keymap.set("i", "kj", "<Esc>", {
  silent = true,
})

-- Keymap that opens up oil as the default file explorer for me
vim.keymap.set("n", "<leader>o", "<cmd>Oil<cr>", { desc = "Open parent directory" })

-- Show which line your cursor is on
vim.opt.cursorline = false

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Setup cursorcolumn
vim.opt.colorcolumn = "80"
vim.opt.cursorcolumn = false

-- Disable backup and swapfile
vim.opt.swapfile = false
vim.opt.backup = false

-- Tabs vs Spaces debate
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.list = true

-- Render any special character as whitespace
vim.opt.listchars = { tab = "  ", trail = " ", nbsp = " ", eol = " " }
