---@module 'lazy'
---@type LazySpec
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = { theme = "gruvbox" },
    sections = {
      lualine_a = {
        function()
          local ok, pomo = pcall(require, "pomo")
          if not ok then return "" end
          local timer = pomo.get_first_to_finish()
          if timer == nil then return "" end
          return "󰄉 " .. tostring(timer)
        end,
        {
          "lsp_status",
          icon = "", -- f013
          symbols = {
            -- Standard unicode symbols to cycle through for LSP progress:
            spinner = {
              "⠋",
              "⠙",
              "⠹",
              "⠸",
              "⠼",
              "⠴",
              "⠦",
              "⠧",
              "⠇",
              "⠏",
            },
            -- Standard unicode symbol for when LSP is done:
            done = "✓",
            -- Delimiter inserted between LSP names:
            separator = " ",
          },
          -- List of LSP names to ignore (e.g., `null-ls`):
          ignore_lsp = {},
          -- Display the LSP name
          show_name = true,
        },
      },
    },
  },
}
