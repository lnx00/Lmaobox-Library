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

-- Projectile info by definition index
local projInfo = {
    [414] = { 1540, 0 }, -- Liberty Launcher
    [308] = { 1513.3, 0.4 }, -- Loch n' Load
    [595] = { 3000, 0.2 }, -- Manmelter
}

-- Projectile info by weapon ID
local projInfoID = {
    [E_WeaponBaseID.TF_WEAPON_ROCKETLAUNCHER] = { 1100, 0 }, -- Rocket Launcher
    [E_WeaponBaseID.TF_WEAPON_DIRECTHIT] = { 1980, 0 }, -- Direct Hit
    [E_WeaponBaseID.TF_WEAPON_GRENADELAUNCHER] = { 1216.6, 0.5 }, -- Grenade Launcher
    [E_WeaponBaseID.TF_WEAPON_PIPEBOMBLAUNCHER] = { 1100, 0 }, -- Rocket Launcher
    [E_WeaponBaseID.TF_WEAPON_SYRINGEGUN_MEDIC] = { 1000, 0.2 }, -- Syringe Gun
    [E_WeaponBaseID.TF_WEAPON_FLAMETHROWER] = { 1000, 0.2, 0.33 }, -- Flame Thrower
    [E_WeaponBaseID.TF_WEAPON_FLAREGUN] = { 2000, 0.3 }, -- Flare Gun
    [E_WeaponBaseID.TF_WEAPON_CLEAVER] = { 3000, 0.2 }, -- Flying Guillotine
    [E_WeaponBaseID.TF_WEAPON_CROSSBOW] = { 2400, 0.2 }, -- Crusader's Crossbow
    [E_WeaponBaseID.TF_WEAPON_SHOTGUN_BUILDING_RESCUE] = { 2400, 0.2 }, -- Rescue Ranger
    [E_WeaponBaseID.TF_WEAPON_CANNON] = { 1453.9, 0.4 }, -- Loose Cannon
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

-- Returns the projectile speed and gravity of the weapon
---@return table<number, number>?
function WWeapon:GetProjectileInfo()
    local id = self:GetWeaponID()
    local defIndex = self:GetDefIndex()

    -- Special cases
    if id == E_WeaponBaseID.TF_WEAPON_COMPOUND_BOW then
        local charge = globals.CurTime() - self:GetChargeBeginTime()
        return { Math.RemapValClamped(charge, 0.0, 1.0, 1800, 2600),
                 Math.RemapValClamped(charge, 0.0, 1.0, 0.5, 0.1) }
    elseif id == E_WeaponBaseID.TF_WEAPON_PIPEBOMBLAUNCHER then
        local charge = globals.CurTime() - self:GetChargeBeginTime()
        return { Math.RemapValClamped(charge, 0.0, 4.0, 900, 2400),
                 Math.RemapValClamped(charge, 0.0, 4.0, 0.5, 0.0) }
    end

    return projInfo[defIndex] or projInfoID[id]
end

return WWeapon
