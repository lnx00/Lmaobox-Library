---@class Utils
---@field public conversion Conversion
---@field public fs FileSystem
---@field public keys Input
---@field public KeyHelper KeyHelper
---@field public Logger Logger
---@field public mathx Math
---@field public Timer Timer
---@field public Config Config
---@field public commands Commands
local utils = {
    conversion = require("src/Utils/Conversion"),
    fs = require("src/Utils/FileSystem"),
    keys = require("src/Utils/Input"),
    kv = require("src/Utils/KeyValues"),
    mathx = require("src/Utils/Math"),
    commands = require("src/Utils/Commands"),
    Config = require("src/Utils/Config"),
    KeyHelper = require("src/Utils/KeyHelper"),
    Logger = require("src/Utils/Logger"),
    Timer = require("src/Utils/Timer"),
}

-- Removes all special characters from a string
---@param str string
---@return string
function utils.sanitize(str)
    str = string.gsub(str, "[%p%c]", "")
    str = string.gsub(str, '"', "'")
    return str
end

-- Generates a rainbow color
---@param offset number
---@return integer, integer, integer
function utils.rainbow(offset)
    local r = math.floor(math.sin(offset + 0) * 127 + 128)
    local g = math.floor(math.sin(offset + 2) * 127 + 128)
    local b = math.floor(math.sin(offset + 4) * 127 + 128)
    return r, g, b
end

-- Unloads all packages that contain the given name
---@param libName string
---@return integer
function utils.unload_packages(libName)
    local unloadCount = 0
    for name, _ in pairs(package.loaded) do
        if string.find(name, libName) then
            print(string.format("Unloading package '%s'...", name))
            package.loaded[name] = nil
            unloadCount = unloadCount + 1
        end
    end

    warn(string.format("All packages of '%s' have been unloaded!", libName))
    return unloadCount
end

return utils
