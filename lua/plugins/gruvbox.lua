return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  setup = {
    transparent = true,
  },
  config = function()
    vim.o.background = "dark"
    vim.cmd("colorscheme gruvbox")
  end,
}
