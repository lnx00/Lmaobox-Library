--[[
    Wrapper Class for Wepaon Entities
]]

---@type WEntity
local WEntity = require("lnxLib/TF2/Wrappers/WEntity")

---@type Math
local Math = require("lnxLib/Utils/Math")

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
    [TF_WEAPON_ROCKETLAUNCHER] = { 1100, 0 }, -- Rocket Launcher
    [TF_WEAPON_DIRECTHIT] = { 1980, 0 }, -- Direct Hit
    [TF_WEAPON_GRENADELAUNCHER] = { 1216.6, 0.5 }, -- Grenade Launcher
    [TF_WEAPON_PIPEBOMBLAUNCHER] = { 1100, 0 }, -- Rocket Launcher
    [TF_WEAPON_SYRINGEGUN_MEDIC] = { 1000, 0.2 }, -- Syringe Gun
    [TF_WEAPON_FLAMETHROWER] = { 1000, 0.2, 0.33 }, -- Flame Thrower
    [TF_WEAPON_FLAREGUN] = { 2000, 0.3 }, -- Flare Gun
    [TF_WEAPON_CLEAVER] = { 3000, 0.2 }, -- Flying Guillotine
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
    local id = self:GetWeaponID()
    local defIndex = self:GetDefIndex()

    if id == TF_WEAPON_COMPOUND_BOW then
        local charge = globals.CurTime() - self:GetChargeBeginTime()
        return { Math.RemapValClamped(charge, 0.0, 1.0, 1800, 2600),
                 Math.RemapValClamped(charge, 0.0, 1.0, 0.5, 0.1) }
    elseif id == TF_WEAPON_PIPEBOMBLAUNCHER then
        local charge = globals.CurTime() - self:GetChargeBeginTime()
        return { Math.RemapValClamped(charge, 0.0, 4.0, 900, 2400),
                 Math.RemapValClamped(charge, 0.0, 4.0, 0.5, 0.0) }
    elseif defIndex == 414 then
        -- Liberty Launcher
        return { 1540, 0 }
    end

    return projInfo[id]
end

return WWeapon
