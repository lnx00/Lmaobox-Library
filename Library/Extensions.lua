--[[
    Extensions for Lua
]]

function math.clamp(n, low, high)
    return math.min(math.max(n, low), high)
end