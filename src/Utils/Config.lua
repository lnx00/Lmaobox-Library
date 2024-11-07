---@type FileSystem
local FileSystem = require("src/Utils/FileSystem")

-- Stub dkjson if it's not available
local jsonAvailable, Json = pcall(require, "dkjson")
if not jsonAvailable then
    local msg = "dkjson not found, Config system will be unavailable!"
    Json = {
        encode = function(...) return "", error(msg) end,
        decode = function(...) return {}, error(msg) end
    }
end

---@class Config
---@field private _name string
---@field private _content table
---@field public auto_save boolean
---@field public auto_load boolean
local Config = {
    _name = "",
    _content = {},
    auto_save = true,
    auto_load = false
}
Config.__index = Config

local ConfigExtension = ".cfg"
local ConfigFolder = FileSystem.get_work_dir() .. "/Configs/"

---Creates a new config
---@param name string
---@return Config
function Config.new(name)
    local self = setmetatable({}, Config)
    self._name = name
    self._content = {}
    self.auto_save = true
    self.auto_load = false

    self:load()

    return self
end

---Returns the path of the config file
---@return string
function Config:get_path()
    if not FileSystem.exists(ConfigFolder) then
        filesystem.CreateDirectory(ConfigFolder)
    end

    return ConfigFolder .. self._name .. ConfigExtension
end

---Loads the config file
---@return boolean
function Config:load()
    local configPath = self:get_path()
    if not FileSystem.exists(configPath) then return false end

    local content = FileSystem.read(self:get_path())
    self._content = Json.decode(content, 1, nil)
    return self._content ~= nil
end

---Deletes the config file
---@return boolean
function Config:delete()
    local configPath = self:get_path()
    if not FileSystem.exists(configPath) then return false end

    self._content = {}
    return FileSystem.delete(configPath)
end

---Saves the config file
---@return boolean
function Config:save()
    local content = Json.encode(self._content, { indent = true })
    return FileSystem.write(self:get_path(), content)
end

---Sets a value in the config file
---@param key string
---@param value any
function Config:set(key, value)
    if self.auto_load then self:load() end
    self._content[key] = value
    if self.auto_save then self:save() end
end

---Retrieves a value from the config file
---@generic T
---@param key string
---@param default T
---@return T
function Config:get(key, default)
    if self.auto_load then self:load() end

    local value = self._content[key]
    return (value ~= nil) and value or default
end

return Config
