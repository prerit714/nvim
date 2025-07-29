return {
  "zenbones-theme/zenbones.nvim",
  dependencies = "rktjmp/lush.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.zenbones_darken_comments = 80
    -- Enable transparency
    vim.g.zenbones_transparent_background = true

    vim.cmd.colorscheme "kanagawabones"

    -- Additional transparency settings (if needed)
    vim.cmd [[
            highlight Normal guibg=NONE ctermbg=NONE
            highlight NonText guibg=NONE ctermbg=NONE
            highlight SignColumn guibg=NONE ctermbg=NONE
            highlight NormalFloat guibg=NONE ctermbg=NONE
            highlight FloatBorder guibg=NONE ctermbg=NONE
        ]]
  end,
}
