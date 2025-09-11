return {
  "vague2k/vague.nvim",
  lazy = false,
  priority = 1000,
  setup = {
    transparent = true,
  },
  config = function()
    vim.cmd("colorscheme vague")
    vim.cmd [[
      highlight Normal guibg=NONE ctermbg=NONE
      highlight NonText guibg=NONE ctermbg=NONE
      highlight SignColumn guibg=NONE ctermbg=NONE
      highlight NormalFloat guibg=NONE ctermbg=NONE
      highlight FloatBorder guibg=NONE ctermbg=NONE
    ]]
  end,
}
