---@class Utils
---@field public Conversion Conversion
---@field public FileSystem FileSystem
---@field public Web Web
---@field public Input Input
---@field public KeyHelper KeyHelper
---@field public Logger Logger
---@field public Timer Timer
---@field public Config Config
---@field public Commands Commands
local Utils = {
    Conversion = require("Library/Utils/Conversion"),
    FileSystem = require("Library/Utils/FileSystem"),
    Web = require("Library/Utils/Web"),
    Input = require("Library/Utils/Input"),
    KeyHelper = require("Library/Utils/KeyHelper"),
    Logger = require("Library/Utils/Logger"),
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
---@return integer, integer, integer
function Utils.Rainbow(offset)
    local r = math.floor(math.sin(offset + 0) * 127 + 128)
    local g = math.floor(math.sin(offset + 2) * 127 + 128)
    local b = math.floor(math.sin(offset + 4) * 127 + 128)
    return r, g, b
end

-- Unloads all packages that contain the given name
---@param libName string
---@return integer
function Utils.UnloadPackages(libName)
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

return Utils
