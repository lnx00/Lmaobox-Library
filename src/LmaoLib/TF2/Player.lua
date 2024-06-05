--[[
    Wrapper Class for Player Entities
]]

---@class Player
local Player = {}

--[[ Wrapper functions ]]

-- Returns whether the player is on the ground
---@param player Entity
---@return boolean
function Player.IsOnGround(player)
    local pFlags = player:GetPropInt("m_fFlags")
    return (pFlags & FL_ONGROUND) == 1
end

-- Returns the active weapon
---@param player Entity
---@return Entity?
function Player.GetActiveWeapon(player)
    return player:GetPropEntity("m_hActiveWeapon")
end

---@param player Entity
---@return number
function Player.GetObserverMode(player)
    return player:GetPropInt("m_iObserverMode")
end

-- Returns the spectated target
---@param player Entity
---@return Entity?
function Player.GetObserverTarget(player)
    return player:GetPropEntity("m_hObserverTarget")
end

-- Returns when the player can attack again
---@param player Entity
---@return number
function Player.GetNextAttack(player)
    return player:GetPropFloat("m_flNextAttack")
end

-- Returns the position of the hitbox as a Vector3
---@param player Entity
---@param hitboxID number
---@return Vector3?
function Player.GetHitboxPos(player, hitboxID)
    local hitbox = player:GetHitboxes()[hitboxID]
    if not hitbox then return nil end

    return (hitbox[1] + hitbox[2]) * 0.5
end

---Returns the player's view offset from his feets
---@param player Entity
---@return Vector3
function Player.GetViewOffset(player)
    return player:GetPropVector("localdata", "m_vecViewOffset[0]")
end

---Returns the player's eye position in world space
---@param player Entity
---@return Vector3
function Player.GetEyePos(player)
    return player:GetAbsOrigin() + Player.GetViewOffset(player)
end

---@param player Entity
---@return EulerAngles
function Player.GetEyeAngles(player)
    local angles = player:GetPropVector("tfnonlocaldata", "m_angEyeAngles[0]")
    return EulerAngles(angles.x, angles.y, angles.z)
end

-- Returns the position the player is looking at
---@param player Entity
---@return Vector3
function Player.GetViewPos(player)
    local eyePos = Player.GetEyePos(player)
    local targetPos = eyePos + Player.GetEyeAngles(player):Forward() * 8192
    local trace = engine.TraceLine(eyePos, targetPos, MASK_SHOT)

    return trace.endpos
end

return Player
