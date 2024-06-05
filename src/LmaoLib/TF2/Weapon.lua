--[[
    Wrapper Class for Wepaon Entities
]]

---@type Math
local Math = require("LmaoLib/Utils/Math")

---@class Weapon
local Weapon = {}

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

--[[ Helper functions ]]

---@param weapon Entity
---@return Entity
function Weapon.GetOwner(weapon)
    return weapon:GetPropEntity("m_hOwner")
end

---@param weapon Entity
---@return number
function Weapon.GetDefIndex(weapon)
    return weapon:GetPropInt("m_iItemDefinitionIndex")
end

---@param weapon Entity
---@return number
function Weapon.GetNextPrimaryAttack(weapon)
    return weapon:GetPropFloat("m_flNextPrimaryAttack")
end

---@param weapon Entity
---@return number
function Weapon.GetChargeBeginTime(weapon)
    return weapon:GetPropFloat("m_flChargeBeginTime")
end

---@param weapon Entity
---@return number
function Weapon.GetChargedDamage(weapon)
    return weapon:GetPropFloat("m_flChargedDamage")
end

-- Returns the projectile speed and gravity of the weapon
---@param weapon Entity
---@return table<number, number>?
function Weapon.GetProjectileInfo(weapon)
    local id = weapon:GetWeaponID()
    local defIndex = weapon:ToInventoryItem():GetDefIndex()

    -- Special cases
    if id == E_WeaponBaseID.TF_WEAPON_COMPOUND_BOW then
        local charge = globals.CurTime() - weapon:GetChargeBeginTime()
        return { Math.RemapValClamped(charge, 0.0, 1.0, 1800, 2600),
                 Math.RemapValClamped(charge, 0.0, 1.0, 0.5, 0.1) }
    elseif id == E_WeaponBaseID.TF_WEAPON_PIPEBOMBLAUNCHER then
        local charge = globals.CurTime() - weapon:GetChargeBeginTime()
        return { Math.RemapValClamped(charge, 0.0, 4.0, 900, 2400),
                 Math.RemapValClamped(charge, 0.0, 4.0, 0.5, 0.0) }
    end

    return projInfo[defIndex] or projInfoID[id]
end

return Weapon
