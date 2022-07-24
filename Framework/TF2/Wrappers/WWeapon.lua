--[[
    Wrapper Class for Wepaon Entities
]]

local WEntity = require(LNXF_PATH .. "TF2/Wrappers/WEntity")

---@class WWeapon
local WWeapon = {
    Entity = nil
}
WWeapon.__index = WWeapon
setmetatable(WWeapon, WEntity)

--[[ Contructors ]]

-- Creates a WWeapon from a given native Entity
function WWeapon.FromEntity(entity)
    assert(entity:IsWeapon(), "WWeapon.FromEntity: entity is not a weapon")

    local self = setmetatable({ }, WWeapon)
    self.Entity = entity

    return self
end

-- Creates a WWeapon from a given WEntity
function WWeapon.FromWEntity(wEntity)
    return WWeapon.FromEntity(wEntity.Entity)
end

--[[ Wrapper functions ]]

-- Returns if the weapon can shoot
function WWeapon:CanShoot(lPlayer)
    if (not WWeapon.Entity) or (self.Entity:IsMeleeWeapon()) then return false end

    local nextPrimaryAttack = self.Entity:GetPropFloat("LocalActiveWeaponData", "m_flNextPrimaryAttack")
    local nextAttack = lPlayer:GetPropFloat("bcc_localdata", "m_flNextAttack")
    if (not nextPrimaryAttack) or (not nextAttack) then return false end

    return (nextPrimaryAttack <= globals.CurTime()) and (nextAttack <= globals.CurTime())
end

return WWeapon