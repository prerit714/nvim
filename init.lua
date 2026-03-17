if vim.g.neovide then
  vim.g.neovide_scale_factor = 1.0

  local function change_scale(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end

  -- Ctrl+= zoom in, Ctrl+- zoom out, Ctrl+0 reset
  vim.keymap.set({ "n", "v", "i" }, "<C-=>", function() change_scale(1.1) end)
  vim.keymap.set(
    { "n", "v", "i" },
    "<C-->",
    function() change_scale(1 / 1.1) end
  )
  vim.keymap.set(
    { "n", "v", "i" },
    "<C-0>",
    function() vim.g.neovide_scale_factor = 1.0 end
  )
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

require("options")
require("keymaps")
require("lazy-bootstrap")
require("lazy-plugins")
