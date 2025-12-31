return {
  name = "Java run",
  builder = function()
    local file = vim.fn.expand "%:p"

    -- Run task
    return {
      name = "run",
      cmd = "java",
      args = { file },
      cwd = vim.fn.expand "%:p:h",
      components = { "default" },
    }
  end,
  condition = {
    filetype = { "java" },
  },
}
