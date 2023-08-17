--[[
    Helpers
]]

---@class Helpers
local Helpers = {}

-- Computes the move vector between two points
---@param userCmd UserCmd
---@param a Vector3
---@param b Vector3
---@return Vector3
local function ComputeMove(userCmd, a, b)
    local diff = (b - a)
    if diff:Length() == 0 then return Vector3(0, 0, 0) end

    local x = diff.x
    local y = diff.y
    local vSilent = Vector3(x, y, 0)

    local ang = vSilent:Angles()
    local cPitch, cYaw, cRoll = userCmd:GetViewAngles()
    local yaw = math.rad(ang.y - cYaw)
    local pitch = math.rad(ang.x - cPitch)
    local move = Vector3(math.cos(yaw) * 450, -math.sin(yaw) * 450, -math.cos(pitch) * 450)

    return move
end

-- Walks to the destination
---@param userCmd UserCmd
---@param localPlayer Entity
---@param destination Vector3
function Helpers.WalkTo(userCmd, localPlayer, destination)
    local localPos = localPlayer:GetAbsOrigin()
    local result = ComputeMove(userCmd, localPos, destination)

    userCmd:SetForwardMove(result.x)
    userCmd:SetSideMove(result.y)
end

-- Returns if the weapon can shoot
---@param weapon Entity
---@return boolean
function Helpers.CanShoot(weapon)
    local lPlayer = entities.GetLocalPlayer()
    if not lPlayer or weapon:IsMeleeWeapon() then return false end

    local nextPrimaryAttack = weapon:GetPropFloat("LocalActiveWeaponData", "m_flNextPrimaryAttack")
    local nextAttack = lPlayer:GetPropFloat("bcc_localdata", "m_flNextAttack")
    if (not nextPrimaryAttack) or (not nextAttack) then return false end

    return (nextPrimaryAttack <= globals.CurTime()) and (nextAttack <= globals.CurTime())
end

-- Returns if the player is visible
---@param target Entity
---@param from Vector3
---@param to Vector3
---@return boolean
function Helpers.VisPos(target, from, to)
    local trace = engine.TraceLine(from, to, (CONTENTS_SOLID|CONTENTS_MOVEABLE|CONTENTS_MONSTER|CONTENTS_WINDOW|CONTENTS_DEBRIS|0x40000000) | CONTENTS_GRATE)
    return (trace.entity == target) or (trace.fraction > 0.99)
end

-- Returns the screen bounding box of the player (or nil if the player is not visible)
---@param player WPlayer
---@return {x:number, y:number, w:number, h:number}|nil
function Helpers.GetBBox(player)
    local padding = Vector3(0, 0, 10)
    local headPos = player:GetEyePos() + padding
    local feetPos = player:GetAbsOrigin() - padding

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

return Helpers
