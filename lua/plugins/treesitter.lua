return {
  "nvim-treesitter/nvim-treesitter-context",
  name = "treesitter-context",
  lazy = false,
  opts = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      -- NOTE: Add http to the list of parsers to install
      vim.list_extend(opts.ensure_installed, { "http" })
    end
  end,
  keys = {
    {
      "<leader>tc",
      "<cmd>TSContextToggle<cr>",
      desc = "Toggle tree-sitter context",
    },
  },
}
