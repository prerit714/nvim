-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Limit for a code block
vim.opt.colorcolumn = "80"

-- Turn off relative numbers
vim.opt.relativenumber = false

vim.g.snacks_animate = false

vim.opt.wrap = false

-- Invisible chars show
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
