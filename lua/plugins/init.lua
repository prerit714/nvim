return {
  -- Rose-pine is pretty good
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      undercurl = false,
      underline = false,
      bold = false,
      italic = {
        strings = false,
        emphasis = false,
        operators = false,
        folds = false,
        comments = false,
      },
    },
  },

  -- Configure LazyVim to load rose-pine
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },

  -- Using Oil as a file explorer
  {
    "stevearc/oil.nvim",
    dependencies = vim.g.have_nerd_font or { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = true,
    },
  },
  -- Using vim fugitive instead of lazygit
  {
    "tpope/vim-fugitive",
    lazy = false,
  },
  -- Disable annoying indent guides
  {
    "folke/snacks.nvim",
    opts = {
      indent = {
        enabled = false,
      },
    },
  },
  -- Custom tree-sitter stuff
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "diff",
        "html",
        "lua",
        "luadoc",
        "vim",
        "vimdoc",
        "typescript",
        "rust",
        "go",
        "http",
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = { enable = true, disable = { "ruby" } },
    },
  },
  -- tree-sitter context gud
  {
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
  },
  {
    "folke/noice.nvim",
    opts = {
      routes = {
        {
          filter = {
            event = "notify",
            find = "No information available",
          },
          opts = {
            skip = true,
          },
        },
      },
    },
  },
  -- Disable inlay hints by default
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
  },
}
