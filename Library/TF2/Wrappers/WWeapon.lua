--[[
    Wrapper Class for Wepaon Entities
]]

---@type WEntity
local WEntity = require("Library/TF2/Wrappers/WEntity")

---@class WWeapon : WEntity
local WWeapon = { }
WWeapon.__index = WWeapon
setmetatable(WWeapon, WEntity)

--[[ Contructors ]]

-- Creates a WWeapon from a given native Entity
---@param entity Entity
---@return WWeapon
function WWeapon.FromEntity(entity)
    assert(entity:IsWeapon(), "WWeapon.FromEntity: entity is not a weapon")

    ---@type self
    local self = setmetatable({ }, WWeapon)
    self.Entity = entity

    return self
end

--[[ Wrapper functions ]]

---@return Entity
function WWeapon:GetOwner()
    return self:GetPropEntity("m_hOwner")
end

---@return number
function WWeapon:GetDefIndex()
    return self:GetPropInt("m_iItemDefinitionIndex")
end

return WWeapon