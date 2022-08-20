--[[
    Wrapper Class for Player Entities
]]

local WEntity = require("Library/TF2/Wrappers/WEntity")
local WWeapon = require("Library/TF2/Wrappers/WWeapon")

---@class WPlayer : WEntity
local WPlayer = { }
WPlayer.__index = WPlayer
setmetatable(WPlayer, WEntity)

--[[ Constructors ]]

-- Creates a WPlayer from a given native Entity
---@param entity Entity
---@return WPlayer
function WPlayer.FromEntity(entity)
    assert(entity:IsPlayer(), "WPlayer.FromEntity: entity is not a player")

    ---@type self
    local self = setmetatable({ }, WPlayer)
    self.Entity = entity

    return self
end

-- Returns a WPlayer of the local player
---@return WPlayer
function WPlayer.GetLocalPlayer()
    return WPlayer.FromEntity(entities.GetLocalPlayer())
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

-- Returns the spectated target
---@return WPlayer
function WPlayer:GetObservedTarget()
    return WPlayer.FromEntity(self:GetPropEntity("m_hObserverTarget"))
end

-- Returns the position of the hitbox as a Vector3
---@param hitbox number
---@return Vector3
function WEntity:GetHitboxPos(hitbox)
    local hitbox = self:GetHitboxes()[hitbox]
    if not hitbox then return Vector3() end

    return (hitbox[1] + hitbox[2]) * 0.5
end

return WPlayer