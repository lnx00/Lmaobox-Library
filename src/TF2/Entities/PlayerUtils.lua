--[[
    Wrapper Class for Player Entities
]]

---@class PlayerUtils
local playerutil = {}

--[[ Wrapper functions ]]

-- Returns whether the player is on the ground
---@param player Entity
---@return boolean
function playerutil.on_ground(player)
    local pFlags = player:GetPropInt("m_fFlags")
    return (pFlags & FL_ONGROUND) == 1
end

-- Returns the active weapon
---@param player Entity
---@return Entity?
function playerutil.active_weapon(player)
    return player:GetPropEntity("m_hActiveWeapon")
end

---@param player Entity
---@return number
function playerutil.observer_mode(player)
    return player:GetPropInt("m_iObserverMode")
end

-- Returns the spectated target
---@param player Entity
---@return Entity?
function playerutil.observer_target(player)
    return player:GetPropEntity("m_hObserverTarget")
end

-- Returns when the player can attack again
---@param player Entity
---@return number
function playerutil.next_attack(player)
    return player:GetPropFloat("m_flNextAttack")
end

-- Returns the position of the hitbox as a Vector3
---@param player Entity
---@param hitboxID number
---@return Vector3?
function playerutil.hitpox_pos(player, hitboxID)
    local hitbox = player:GetHitboxes()[hitboxID]
    if not hitbox then return nil end

    return (hitbox[1] + hitbox[2]) * 0.5
end

---Returns the player's view offset from his feets
---@param player Entity
---@return Vector3
function playerutil.view_offset(player)
    return player:GetPropVector("localdata", "m_vecViewOffset[0]")
end

---Returns the player's eye position in world space
---@param player Entity
---@return Vector3
function playerutil.eye_pos(player)
    return player:GetAbsOrigin() + playerutil.view_offset(player)
end

---@param player Entity
---@return EulerAngles
function playerutil.eye_angles(player)
    local angles = player:GetPropVector("tfnonlocaldata", "m_angEyeAngles[0]")
    return EulerAngles(angles.x, angles.y, angles.z)
end

-- Returns the position the player is looking at
---@param player Entity
---@return Vector3
function playerutil.view_pos(player)
    local eyePos = playerutil.eye_pos(player)
    local targetPos = eyePos + playerutil.eye_angles(player):Forward() * 8192
    local trace = engine.TraceLine(eyePos, targetPos, MASK_SHOT)

    return trace.endpos
end

-- Returns the screen bounding box of the player (or nil if the player is not visible)
---@param player Entity
---@return {x:number, y:number, w:number, h:number}?
function playerutil.bbox(player)
    local padding = Vector3(0, 0, 10)
    local feetPos = player:GetAbsOrigin() - padding
    local headPos = playerutil.eye_pos(player) + padding

    local headScreenPos = client.WorldToScreen(headPos)
    local feetScreenPos = client.WorldToScreen(feetPos)
    if (not headScreenPos) or (not feetScreenPos) then return nil end

    local height = math.abs(headScreenPos[2] - feetScreenPos[2])
    local width = height * 0.6

    return {
        x = math.floor(headScreenPos[1] - width * 0.5),
        y = math.floor(headScreenPos[2]),
        w = math.floor(width),
        h = math.floor(height)
    }
end

return playerutil
