-- Letting enable or disable copilot here

local is_copilot_enabled = true

if not is_copilot_enabled then
  return {}
end

return {
  "github/copilot.vim",
}
