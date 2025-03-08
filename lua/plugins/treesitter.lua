return {
  "nvim-treesitter/nvim-treesitter-context",
  name = "treesitter-context",
  lazy = false,
  opts = {},
  keys = {
    {
      "<leader>tc",
      "<cmd>TSContextToggle<cr>",
      desc = "Toggle tree-sitter context",
    },
  },
}
