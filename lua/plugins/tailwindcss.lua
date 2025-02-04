-- In ~/.config/nvim/lua/plugins/tailwind.lua

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          filetypes = {
            "rust", -- Enable for Rust files
            "html",
            "css",
          },
          init_options = {
            userLanguages = {
              rust = "html", -- Treat Rust files as HTML for Tailwind
            },
          },
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  -- For Dioxus class! macro
                  'class!\\s*\\(\\s*"([^"]*)"\\s*\\)',
                  -- For regular class strings
                  'class="([^"]*)"',
                },
              },
              validate = true,
            },
          },
        },
      },
    },
  },

  -- Optional: Add Tailwind CSS colors to colorizer
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },

  -- Don't show unknownAtRules error
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cssls = {
          settings = {
            css = {
              lint = {
                unknownAtRules = "ignore",
              },
            },
            scss = {
              lint = {
                unknownAtRules = "ignore",
              },
            },
            less = {
              lint = {
                unknownAtRules = "ignore",
              },
            },
          },
        },
      },
    },
  },
}
