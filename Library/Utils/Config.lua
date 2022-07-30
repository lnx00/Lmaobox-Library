---@type IO
local IO = require(LIB_PATH .. "Utils/IO")

---@type Json
local Json = require(LIB_PATH .. "Libs/json")

---@class Config
---@field private _Name string
---@field private _Content table
---@field public AutoSave boolean
---@field public AutoLoad boolean
local Config = {
    _Name = "",
    _Content = { },
    AutoSave = true,
    AutoLoad = false
}
Config.__index = Config
setmetatable(Config, Config)

local ConfigExtension = ".cfg"
local ConfigFolder = IO.GetWorkDir() .. "/Configs/"

---@return Config
function Config.new(name)
    ---@type self
    local self = setmetatable({ }, Config)
    self._Name = name
    self._Content = { }
    self.AutoSave = true
    self.AutoLoad = false

    self:Load()

    return self
end

---@return string
function Config:GetPath()
    if not IO.Exists(ConfigFolder) then
        filesystem.CreateDirectory(ConfigFolder)
    end

    return ConfigFolder .. self._Name .. ConfigExtension
end

function Config:Load()
    local configPath = self:GetPath()
    if not IO.Exists(configPath) then return end

    local content = IO.ReadFile(self:GetPath())
    self._Content = Json.decode(content)
end

function Config:Delete()
    local configPath = self:GetPath()
    if not IO.Exists(configPath) then return end

    IO.DeleteFile(configPath)
    self._Content = { }
end

function Config:Save()
    local content = Json.encode(self._Content)
    IO.WriteFile(self:GetPath(), content)
end

---@param key string
---@param value any
function Config:SetValue(key, value)
    if self.AutoLoad then self:Load() end
    self._Content[key] = value
    if self.AutoSave then self:Save() end
end

---@generic T
---@param key string
---@param default T
---@return T
function Config:GetValue(key, default)
    if self.AutoLoad then self:Load() end
    local value =  self._Content[key]
    if value == nil then return default end

    return value
end

return Config