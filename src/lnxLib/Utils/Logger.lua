--[[
    Logging utility
]]

---@class Logger
---@field public Name string
---@field public Level integer
local Logger = {}
Logger.__index = Logger

---@param name string
---@return Logger
function Logger.new(name)
    local self = setmetatable({}, Logger)
    self.Name = name or "Logger"
    self.Level = 1
    return self
end

local logModes = {
    ["Debug"] = { Color = { 165, 175, 190 }, Level = 0 },
    ["Info"]  = { Color = { 15, 185, 180 }, Level = 1 },
    ["Warn"]  = { Color = { 225, 175, 45 }, Level = 2 },
    ["Error"] = { Color = { 230, 65, 25 }, Level = 3 }
}

local function getCurrentTime()
    -- Update the timestamp at most once per second.
    local currentTime = os.time()
    if not Logger.lastTime or currentTime > Logger.lastTime then
        Logger.lastFormattedTime = os.date("%H:%M:%S")
        Logger.lastTime = currentTime
    end
    return Logger.lastFormattedTime
end

-- Initialize the log methods dynamically
for mode, data in pairs(logModes) do
    Logger[mode] = function(self, ...)
        if data.Level < self.Level then return end

        local msg = ...
        local r, g, b = table.unpack(data.Color)
        local time = getCurrentTime()

        local logMsg = "[" .. mode .. " " .. time .. "] " .. self.Name .. ": " .. msg
        printc(r, g, b, 255, logMsg)
    end
end

return Logger
