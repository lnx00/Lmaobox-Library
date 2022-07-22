local IO = require(LNXF_PATH .. "Utils/IO")
local Utils = require(LNXF_PATH .. "Utils/Utils")
local Json = require(LNXF_PATH .. "Libs/json")

local ConfigExtension = ".cfg"
local ConfigFolder = os.getenv('APPDATA') .. "\\LuaConfigs\\"

local Config = {
    Name = "",
    Content = { }
}
Config.__index = Config
setmetatable(Config, Config)

function Config.new(name)
    local self = setmetatable({ }, Config)
    self.Name = name
    self.Content = { }

    self:Load()

    return self
end

function Config:GetPath()
    return ConfigFolder .. self.Name .. ConfigExtension
end

function Config:Load()
    if not IO.FileExists(self.Name) then
        return
    end

    local content = IO.ReadFile(self:GetPath())
end

function Config:Save()
    
end

function Config:SetValue(key, value)
    
end

function Config:GetValue(key, default)
     
end

return Config