-- Define common C++ compilation flags for competitive programming
local cpp_competitive_flags = "-std=c++23 -O2 -Wall -Weffc++ -Wextra -Wshadow -Wconversion -Wsign-conversion -Werror -pedantic-errors -DLOCAL"

local use_non_strict_flags = false
if use_non_strict_flags then
  cpp_competitive_flags = "-std=c++23 -O2"
end

return {
  name = "C++ build",
  builder = function()
    local file = vim.fn.expand "%:p"
    local file_stem = vim.fn.expand "%:t:r"
    local output_path = vim.fn.expand "%:p:h" .. "/" .. file_stem

    -- Make sure flags are properly handled
    local flags = {}
    for flag in string.gmatch(cpp_competitive_flags, "%S+") do
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
