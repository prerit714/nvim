return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      if not vim.g.format_on_save_enabled then
        return nil
      end

      local disable_filetypes = { c = false, cpp = false }

      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = "fallback",
        }
      end
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      typescriptreact = { "biome", stop_after_first = true, lsp_format = "fallback" },
      javascript = { "biome", stop_after_first = true, lsp_format = "fallback" },
      typescript = { "biome", stop_after_first = true, lsp_format = "fallback" },
      json = { "biome", stop_after_first = true, lsp_format = "fallback" },
    },
  },
}
