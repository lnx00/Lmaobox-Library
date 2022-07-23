local IO = require(LNXF_PATH .. "Utils/IO")
local Json = require(LNXF_PATH .. "Libs/json")

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

function Config.new(name)
    local self = setmetatable({ }, Config)
    self._Name = name
    self._Content = { }
    self.AutoSave = true
    self.AutoLoad = false

    self:Load()

    return self
end

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

function Config:Save()
    local content = Json.encode(self._Content)
    IO.WriteFile(self:GetPath(), content)
end

function Config:SetValue(key, value)
    if self.AutoLoad then self:Load() end
    self._Content[key] = value
    if self.AutoSave then self:Save() end
end

function Config:GetValue(key, default)
    if self.AutoLoad then self:Load() end
    local value =  self._Content[key]
    if value == nil then return default end

    return value
end

return Config