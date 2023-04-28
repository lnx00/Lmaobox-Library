--[[
    Helpers
]]

---@class Helpers
local Helpers = {}

local _vUp = Vector3(0, 0, 1)
local _hitbox = { Vector3(-20, -20, 0), Vector3(20, 20, 80) }

-- Used for testing purpose
local function DrawLine(a, b)
    local startPos = client.WorldToScreen(a)
    local endPos = client.WorldToScreen(b)

    if startPos and endPos then
        draw.Color(255, 255, 255, 255)
        draw.Line(startPos[1], startPos[2], endPos[1], endPos[2])
    end
end

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
    local trace = engine.TraceLine(from, to, MASK_SHOT | CONTENTS_GRATE)
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

---@param player WPlayer
---@param t integer
---@return { p: Vector3, v: Vector3, g: boolean }|nil
function Helpers.Predict(player, t)
    local gravity = client.GetConVar("sv_gravity")
    local stepSize = player:GetPropFloat("localdata", "m_flStepSize")
    if not gravity or not stepSize then return nil end

    local vStep = Vector3(0, 0, stepSize)

    local pred = {
        [0] = { p = player:GetAbsOrigin(), v = player:EstimateAbsVelocity(), g = player:IsOnGround() }
    }

    for i = 1, t do
        local last = pred[i - 1]
        if not last then return nil end

        local pos = last.p + last.v * globals.TickInterval()
        local vel = last.v
        local onGround = last.g

        --[[ Forward collision ]]

        local wallTrace = engine.TraceHull(last.p + vStep, pos + vStep, _hitbox[1], _hitbox[2], MASK_SOLID)
        DrawLine(last.p + vStep, pos + vStep)
        if wallTrace.fraction < 1 then
            -- We'll collide
            
            local normal = wallTrace.plane
            if math.abs(normal:Dot(_vUp)) < 0.1 then
                -- Perpendular wall
                local dot = vel:Dot(normal)
                vel = vel - normal * dot
            end

            pos = Vector3(wallTrace.endpos.x, wallTrace.endpos.y, pos.z)
        end

        --[[ Ground collision ]]

        -- Don't step down if we're in-air
        local downStep = vStep
        if not onGround then downStep = Vector3() end

        local groundTrace = engine.TraceHull(pos + vStep, pos - downStep, _hitbox[1], _hitbox[2], MASK_SOLID)
        DrawLine(pos + vStep, pos - downStep)
        if groundTrace.fraction < 1 then
            -- We'll hit the ground
            pos = groundTrace.endpos
            vel = Vector3(vel.x, vel.y, 0)
            onGround = true
        else
            -- We're in the air
            onGround = false
        end

        -- Gravity
        if not onGround then
            vel = Vector3(vel.x, vel.y, vel.z - gravity * globals.TickInterval())
        end

        -- Add the prediction record
        pred[i] = { p = pos, v = vel, g = onGround }
    end

    return pred
end

return Helpers
