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

---@param t table
---@return number
function table.length(t)
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end
    return count
end