local developing_locally = false

if developing_locally then
  return {
    dir = "~/Projects/Lua/cp.nvim",
    name = "cp",
    lazy = false,
    config = function()
      require("cp").setup()
    end
  }
end

return {
  "prerit714/cp.nvim",
  name = "cp",
  lazy = false,
  config = function()
    require("cp").setup()
  end
}
