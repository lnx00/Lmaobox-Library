---@type FS
local FS = require("Library/Utils/FileSystem")

---@type Json
local Json = require("Library/Libs/dkjson")

---@class Config
---@field private _Name string
---@field private _Content table
---@field public AutoSave boolean
---@field public AutoLoad boolean
local Config = {
    _Name = "",
    _Content = {},
    AutoSave = true,
    AutoLoad = false
}
Config.__index = Config
setmetatable(Config, Config)

local ConfigExtension = ".cfg"
local ConfigFolder = FS.GetWorkDir() .. "/Configs/"

-- Creates a new config
---@return Config
function Config.new(name)
    ---@type self
    local self = setmetatable({}, Config)
    self._Name = name
    self._Content = {}
    self.AutoSave = true
    self.AutoLoad = false

    self:Load()

    return self
end

-- Returns the path of the config file
---@return string
function Config:GetPath()
    if not FS.Exists(ConfigFolder) then
        filesystem.CreateDirectory(ConfigFolder)
    end

    return ConfigFolder .. self._Name .. ConfigExtension
end

-- Loads the config file
---@return boolean
function Config:Load()
    local configPath = self:GetPath()
    if not FS.Exists(configPath) then return end

    local content = FS.Read(self:GetPath())
    self._Content = Json.decode(content, 1, nil)
    return self._Content ~= nil
end

-- Deletes the config file
---@return boolean
function Config:Delete()
    local configPath = self:GetPath()
    if not FS.Exists(configPath) then return false end

    self._Content = {}
    return FS.Delete(configPath)
end

-- Saves the config file
---@return boolean
function Config:Save()
    local content = Json.encode(self._Content, { indent = true })
    return FS.Write(self:GetPath(), content)
end

-- Sets a value in the config file
---@param key string
---@param value any
function Config:SetValue(key, value)
    if self.AutoLoad then self:Load() end
    self._Content[key] = value
    if self.AutoSave then self:Save() end
end

-- Retrieves a value from the config file
---@generic T
---@param key string
---@param default T
---@return T
function Config:GetValue(key, default)
    if self.AutoLoad then self:Load() end
    local value = self._Content[key]
    if value == nil then return default end

    return value
end

return Config
