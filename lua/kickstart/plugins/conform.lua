---@module 'lazy'
---@type LazySpec

-- Filetypes whose formatters are too slow for the synchronous on-save path
-- (npm-groovy-lint spins up a JVM). These are formatted asynchronously via
-- format_after_save instead. Pre-seeded, and auto-populated if a sync format
-- ever times out.
local slow_format_filetypes = { groovy = true }

return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    ---@module 'conform'
    ---@diagnostic disable-next-line: undefined-doc-name
    ---@type conform.setupOpts
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        local ft = vim.bo[bufnr].filetype
        if disable_filetypes[ft] or slow_format_filetypes[ft] then
          return nil
        end
        local function on_format(err)
          if err and err:match("timeout$") then
            slow_format_filetypes[ft] = true
          end
        end
        return {
          timeout_ms = 500,
          lsp_format = "fallback",
        }, on_format
      end,
      format_after_save = function(bufnr)
        if not slow_format_filetypes[vim.bo[bufnr].filetype] then
          return nil
        end
        return {
          lsp_format = "fallback",
        }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        java = { "google-java-format" },
        html = { "biome" },
        xml = { "xmlformatter" },
        groovy = { "npm-groovy-lint" },
      },
    },
  },
}
