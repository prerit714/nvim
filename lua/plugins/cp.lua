return {
  dir = "~/Projects/Lua/cp.nvim",
  name = "cp",
  lazy = false,
  config = function()
    require("cp").setup()
  end
}
