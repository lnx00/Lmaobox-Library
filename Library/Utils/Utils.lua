---@class Utils
---@field public Conversion Conversion
---@field public FileSystem FileSystem
---@field public Web Web
---@field public Input Input
---@field public KeyHelper KeyHelper
---@field public Timer Timer
---@field public Config Config
---@field public Commands Commands
local Utils = {
    Conversion = require("Library/Utils/Conversion"),
    FileSystem = require("Library/Utils/FileSystem"),
    Web = require("Library/Utils/Web"),
    Input = require("Library/Utils/Input"),
    KeyHelper = require("Library/Utils/KeyHelper"),
    Timer = require("Library/Utils/Timer"),
    Config = require("Library/Utils/Config"),
    Commands = require("Library/Utils/Commands")
}

-- Removes all special characters from a string
---@param str string
---@return string
function Utils.Sanitize(str)
    _ = str:gsub("%s", "")
    _ = str:gsub("%%", "%%%%")
    return str
end

-- Generates a rainbow color
---@param offset number
---@return number, number, number
function Utils.Rainbow(offset)
    local r = math.floor(math.sin(offset + 0) * 127 + 128)
    local g = math.floor(math.sin(offset + 2) * 127 + 128)
    local b = math.floor(math.sin(offset + 4) * 127 + 128)
    return r, g, b
end

return Utils
