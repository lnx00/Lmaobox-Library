--[[
    Wrapper Class for Player Entities
]]

local WEntity = require(LNXF_PATH .. "TF2/Wrappers/WEntity")

local WPlayer = {
    Entity = nil
}
WPlayer.__index = WPlayer
setmetatable(WPlayer, WEntity)

--[[ Constructors ]]

-- Creates a WPlayer from a given native Entity
function WPlayer.FromEntity(entity)
    assert(entity:IsPlayer(), "WPlayer.FromEntity: entity is not a player")

    local self = setmetatable({ }, WPlayer)
    self.Entity = entity

    return self
end

-- Returns a WPlayer of the local player
function WPlayer.GetLocalPlayer()
    return WPlayer.FromEntity(entities.GetLocalPlayer())
end

-- Creates a WPlayer from a given WEntity
function WPlayer.FromWEntity(wEntity)
    return WPlayer.FromEntity(wEntity.Entity)
end

--[[ Wrapper functions ]]

-- Returns whether the player is on the ground
function WPlayer:IsOnGround()
    local pFlags = self.Entity:GetPropInt("m_fFlags")
    return (pFlags & FL_ONGROUND) == 1
end

-- Returns the active weapon
function WPlayer:GetActiveWeapon()
    return self.Entity:GetPropEntity("m_hActiveWeapon")
end

-- Returns the spectated target
function WPlayer:GetObservedTarget()
    return self.Entity:GetPropEntity("m_hObserverTarget")
end

return WPlayer