---@module 'lazy'
---@type LazySpec
return {
  "mhinz/vim-startify",
  config = function()
    vim.g.startify_lists = {
      { type = "files", header = { "   Files" } },
      {
        type = "dir",
        header = { "   Current Directory " .. vim.fn.getcwd() },
      },
      { type = "sessions", header = { "   Sessions" } },
      { type = "bookmarks", header = { "   Bookmarks" } },
    }

    vim.g.startify_bookmarks = {
      { i = "~/Projects" },
    }
  end,
}
