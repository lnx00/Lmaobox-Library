--[[
    Extensions for Lua
]]

function math.clamp(n, low, high)
    return math.min(math.max(n, low), high)
end

function table.length(t)
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end
    return count
end