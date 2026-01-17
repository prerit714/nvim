return {
  name = "C++ build",
  builder = function()
    local compile_flags = "-std=c++23 -O2"
    local file = vim.fn.expand "%:p"
    local file_stem = vim.fn.expand "%:t:r"
    local output_path = vim.fn.expand "%:p:h" .. "/" .. file_stem .. ".out"

    -- Make sure flags are properly handled
    local flags = {}
    for flag in string.gmatch(compile_flags, "%S+") do
      table.insert(flags, flag)
    end

    -- Add remaining arguments
    table.insert(flags, "-o")
    table.insert(flags, output_path)
    table.insert(flags, file)

    -- Define the tasks
    return {
      name = "compile",
      cmd = "g++",
      args = flags,
      components = { "default" },
    }
  end,
  condition = {
    filetype = { "cpp" },
  },
}
