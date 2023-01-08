--[[
    Logging utility
]]

---@class Logger
---@field public Name string
local Logger = {
    Name = ""
}
Logger.__index = Logger
setmetatable(Logger, Logger)

-- Creates a new logger
---@param name string
---@return Logger
function Logger.new(name)
    ---@type self
    local self = setmetatable({}, Logger)
    self.Name = name

    return self
end

---@vararg any
function Logger:Trace(...)
    local msg = string.format(...)
    local logMsg = string.format("[%-6s%s] %s: %s", "TRACE", os.date("%H:%M:%S"), self.Name, debug.traceback(msg, 2))
    printc(165, 175, 190, 255, logMsg)
end

---@vararg any
function Logger:Info(...)
    local msg = string.format(...)
    local logMsg = string.format("[%-6s%s] %s: %s", "INFO", os.date("%H:%M:%S"), self.Name, msg)
    printc(165, 175, 190, 255, logMsg)
end

---@vararg any
function Logger:Warn(...)
    local msg = string.format(...)
    local logMsg = string.format("[%-6s%s] %s: %s", "WARN", os.date("%H:%M:%S"), self.Name, msg)
    printc(225, 175, 45, 255, logMsg)
end

---@vararg any
function Logger:Error(...)
    local msg = string.format(...)
    local logMsg = string.format("[%-6s%s] %s: %s", "ERROR", os.date("%H:%M:%S"), self.Name, msg)
    printc(230, 65, 25, 255, logMsg)
end

return Logger
