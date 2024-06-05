--[[
    Wrapper Class for Wepaon Entities
]]

---@type Math
local Math = require("LmaoLib/Utils/Math")

---@class WeaponUtils
local WeaponUtils = {}

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

-- Projectile info for special cases (e.g. chargeable weapons)
---@type table<number, function>
local projInfoSpecial = {
    [E_WeaponBaseID.TF_WEAPON_COMPOUND_BOW] = function (weapon)
        local charge = globals.CurTime() - weapon:GetChargeBeginTime()
        return { Math.RemapValClamped(charge, 0.0, 1.0, 1800, 2600),
                 Math.RemapValClamped(charge, 0.0, 1.0, 0.5, 0.1) }
    end,

    [E_WeaponBaseID.TF_WEAPON_PIPEBOMBLAUNCHER] = function (weapon)
        local charge = globals.CurTime() - weapon:GetChargeBeginTime()
        return { Math.RemapValClamped(charge, 0.0, 4.0, 900, 2400),
                 Math.RemapValClamped(charge, 0.0, 4.0, 0.5, 0.0) }
    end
}

--[[ Helper functions ]]

---@param weapon Entity
---@return Entity
function WeaponUtils.GetOwner(weapon)
    return weapon:GetPropEntity("m_hOwner")
end

---@param weapon Entity
---@return number
function WeaponUtils.GetDefIndex(weapon)
    return weapon:GetPropInt("m_iItemDefinitionIndex")
end

---@param weapon Entity
---@return number
function WeaponUtils.GetNextPrimaryAttack(weapon)
    return weapon:GetPropFloat("m_flNextPrimaryAttack")
end

---@param weapon Entity
---@return number
function WeaponUtils.GetChargeBeginTime(weapon)
    return weapon:GetPropFloat("m_flChargeBeginTime")
end

---@param weapon Entity
---@return number
function WeaponUtils.GetChargedDamage(weapon)
    return weapon:GetPropFloat("m_flChargedDamage")
end

-- Returns the projectile speed and gravity of the weapon
---@param weapon Entity
---@return table<number, number>?
function WeaponUtils.GetProjectileInfo(weapon)
    local id = weapon:GetWeaponID()
    local defIndex = weapon:ToInventoryItem():GetDefIndex()

    -- Special cases
    local specialInfo = projInfoSpecial[id]
    if specialInfo then return specialInfo(weapon) end

    -- Regular cases
    return projInfo[defIndex] or projInfoID[id]
end

return WeaponUtils
