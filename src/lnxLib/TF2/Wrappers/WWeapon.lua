--[[
    Wrapper Class for Wepaon Entities
]]

---@type WEntity
local WEntity = require("lnxLib/TF2/Wrappers/WEntity")

---@class WWeapon : WEntity
local WWeapon = {}
WWeapon.__index = WWeapon
setmetatable(WWeapon, WEntity)

local projInfo = {
    [17] = { 1000, 0.2 }, -- Syringe Gun
    [18] = { 1100, 0 }, -- Rocket Launcher
    [19] = { 1216, 0.5 }, -- Grenade Launcher
    [56] = { 2600, 0.1 }, -- Huntsman (Maximum charge only)
    [127] = { 1980, 0 }, -- Direct Hit
    [414] = { 1540, 0 }, -- Liberty Launcher
}

--[[ Contructors ]]

-- Creates a WWeapon from a given native Entity
---@param entity Entity
---@return WWeapon
function WWeapon.FromEntity(entity)
    assert(entity, "WWeapon.FromEntity: entity is nil")
    assert(entity:IsWeapon(), "WWeapon.FromEntity: entity is not a weapon")

    local self = setmetatable({}, WWeapon)
    self:SetEntity(entity)

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

---@return table<number, number>?
function WWeapon:GetProjectileInfo()
    local defIndex = self:GetDefIndex()
    return projInfo[defIndex]
end

return WWeapon
