--[[
    Wrapper Class for Player Entities
]]

---@type WEntity
local WEntity = require("lnxLib/TF2/Wrappers/WEntity")

---@type WWeapon
local WWeapon = require("lnxLib/TF2/Wrappers/WWeapon")

---@class WPlayer : WEntity
local WPlayer = {}
WPlayer.__index = WPlayer
setmetatable(WPlayer, WEntity)

--[[ Constructors ]]

-- Creates a WPlayer from a given native Entity
---@param entity Entity
---@return WPlayer
function WPlayer.FromEntity(entity)
    assert(entity, "WPlayer.FromEntity: entity is nil")
    assert(entity:IsPlayer(), "WPlayer.FromEntity: entity is not a player")

    local self = setmetatable({}, WPlayer)
    self:SetEntity(entity)

    return self
end

-- Returns a WPlayer of the local player
---@return WPlayer?
function WPlayer.GetLocal()
    local lp = entities.GetLocalPlayer()
    return lp ~= nil and WPlayer.FromEntity(lp) or nil
end

--[[ Wrapper functions ]]

-- Returns whether the player is on the ground
---@return boolean
function WPlayer:IsOnGround()
    local pFlags = self:GetPropInt("m_fFlags")
    return (pFlags & FL_ONGROUND) == 1
end

-- Returns the active weapon
---@return WWeapon
function WPlayer:GetActiveWeapon()
    return WWeapon.FromEntity(self:GetPropEntity("m_hActiveWeapon"))
end

---@return number
function WPlayer:GetObserverMode()
    return self:GetPropInt("m_iObserverMode")
end

-- Returns the spectated target
---@return WPlayer
function WPlayer:GetObserverTarget()
    return WPlayer.FromEntity(self:GetPropEntity("m_hObserverTarget"))
end

-- Returns the position of the hitbox as a Vector3
---@param hitboxID number
---@return Vector3
function WPlayer:GetHitboxPos(hitboxID)
    local hitbox = self:GetHitboxes()[hitboxID]
    if not hitbox then return Vector3(0, 0, 0) end

    return (hitbox[1] + hitbox[2]) * 0.5
end

---@return Vector3
function WPlayer:GetViewOffset()
    return self:GetPropVector("localdata", "m_vecViewOffset[0]")
end

---@return Vector3
function WPlayer:GetEyePos()
    return self:GetAbsOrigin() + self:GetViewOffset()
end

---@return EulerAngles
function WPlayer:GetEyeAngles()
    local angles = self:GetPropVector("tfnonlocaldata", "m_angEyeAngles[0]")
    return EulerAngles(angles.x, angles.y, angles.z)
end

-- Returns the position the player is looking at
---@return Vector3
function WPlayer:GetViewPos()
    local eyePos = self:GetEyePos()
    local targetPos = eyePos + self:GetEyeAngles():Forward() * 8192
    local trace = engine.TraceLine(eyePos, targetPos, MASK_SHOT)

    return trace.endpos
end

return WPlayer
