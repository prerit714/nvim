-- Letting enable or disable copilot here

local is_copilot_enabled = false

if is_copilot_enabled then
  return {}
end

return {
  "github/copilot.vim",
}
