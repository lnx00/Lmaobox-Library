--[[
    Wrapper Class for Wepaon Entities
]]

---@type WEntity
local WEntity = require("lnxLib/TF2/Wrappers/WEntity")

---@class WWeapon : WEntity
local WWeapon = {}
WWeapon.__index = WWeapon
setmetatable(WWeapon, WEntity)

local piGroups = {
    RocketLauncher = { 1100, 0 },
    DirectHit = { 1980, 0 },
    LibertyLauncher = { 1540, 0 },
    GrenadeLauncher = { 1216.6, 0.5 },
    Electric = { 1200, 0 },
    LooseCannon = { 1453.9, 0.5 },
    LochnLoad = { 1513.3, 0 },
    Bolts = { 2400, 0.2 },
    DragonsFury = { 3000, 0.2 },
    FlameThrower = { 1000, 0.2 },
    Flare = { 2000, 0.3 },
    Throwable = { 3000, 0.2 },
    Syringe = { 1000, 0.2 }
}

local projInfo = {
    [17] = piGroups.Syringe, -- Syringe Gun
    [18] = piGroups.RocketLauncher, -- Rocket Launcher
    [19] = piGroups.GrenadeLauncher, -- Grenade Launcher
    [127] = piGroups.DirectHit, -- Direct Hit
    [205] = piGroups.RocketLauncher, -- Rocket Launcher
    [206] = piGroups.GrenadeLauncher,
    [414] = piGroups.LibertyLauncher, -- Liberty Launcher
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

---@return number
function WWeapon:GetNextPrimaryAttack()
    return self:GetPropFloat("m_flNextPrimaryAttack")
end

---@return number
function WWeapon:GetChargeBeginTime()
    return self:GetPropFloat("m_flChargeBeginTime")
end

---@return number
function WWeapon:GetChargedDamage()
    return self:GetPropFloat("m_flChargedDamage")
end

---@return table<number, number>?
function WWeapon:GetProjectileInfo()
    local defIndex = self:GetDefIndex()
    return projInfo[defIndex]
end

return WWeapon
