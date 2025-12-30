return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-mini/mini.icons" },
  config = function()
    require("alpha").setup(require("alpha.themes.startify").config)
    -- Open alpha nvim
    vim.api.nvim_set_keymap("n", "<leader>a", ":Alpha<CR>", { noremap = true, silent = true })
  end,
}
