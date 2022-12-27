--[[
    Extensions for Lua
]]

---@param n number
---@param low number
---@param high number
---@return number
function math.clamp(n, low, high)
    return math.min(math.max(n, low), high)
end