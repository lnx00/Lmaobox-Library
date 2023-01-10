--[[
    Logging utility
]]

---@class Logger
---@field public Name string
---@field public Level integer
---@field public Debug fun(...)
---@field public Info fun(...)
---@field public Warn fun(...)
---@field public Error fun(...)
local Logger = {
    Name = "",
    Level = 1
}
Logger.__index = Logger
setmetatable(Logger, Logger)

-- Creates a new logger
---@param name string
---@return Logger
function Logger.new(name)
    local self = setmetatable({}, Logger)
    self.Name = name
    self.Level = 1

    return self
end

---@type table<string, { Color:table, Level:integer }>
local logModes = {
    ["Debug"] = { Color = { 165, 175, 190 }, Level = 0 },
    ["Info"] = { Color = { 15, 185, 180 }, Level = 1 },
    ["Warn"] = { Color = { 225, 175, 45 }, Level = 2 },
    ["Error"] = { Color = { 230, 65, 25 }, Level = 3 }
}

-- Initialize the log methods dynamically
for mode, data in pairs(logModes) do
    rawset(Logger, mode, function(self, ...)
        if data.Level < self.Level then return end

        local msg = string.format(...)

        local r, g, b = table.unpack(data.Color)
        local name = self.Name
        local time = os.date("%H:%M:%S")

        local logMsg = string.format("[%-6s%s] %s: %s", mode, time, name, msg)
        printc(r, g, b, 255, logMsg)
    end)
end

return Logger
