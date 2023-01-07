--[[
    Extensions for Lua
]]

--[[ Math ]]

-- Clamp a number between a low and high value
---@param n number
---@param low number
---@param high number
---@return number
function math.clamp(n, low, high)
    return math.min(math.max(n, low), high)
end

-- Rounds a number to the nearest integer
---@param n number
---@return number
function math.round(n)
    return math.floor(n + 0.5)
end

-- Performs linear interpolation between two numbers.
---@param a number
---@param b number
---@param t number
---@return number
function math.lerp(a, b, t)
    return a + (b - a) * t
end

--[[ Table ]]

-- Returns a read-only version of the given table
---@param t table
---@return table
function table.readOnly(t)
    local proxy = {}
    setmetatable(proxy, {
        __index = t,
        __newindex = function(u, k, v)
            error("Attempt to modify read-only table", 2)
        end
    })

    return proxy
end

-- Performans a linear search on a table and returns the key of the given value
---@param t table
---@param value any
---@return any
function table.find(t, value)
    for k, v in pairs(t) do
        if v == value then return k end
    end

    return nil
end

--[[ String ]]

-- Splits a string into a table of substrings based on a specified delimiter
---@param str string
---@param delimiter string
---@return string[]
function string.split(str, delimiter)
    local result = {}
    local from = 1
    local delim_from, delim_to = string.find(str, delimiter, from)
    while delim_from do
        table.insert(result, string.sub(str, from, delim_from - 1))
        from = delim_to + 1
        delim_from, delim_to = string.find(str, delimiter, from)
    end

    table.insert(result, string.sub(str, from))
    return result
end