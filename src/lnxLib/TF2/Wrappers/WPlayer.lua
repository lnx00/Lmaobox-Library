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

-- Predicts where the player will be in t ticks
---@param t integer
---@return { p: Vector3, v: Vector3, g: boolean }[] | nil
function WPlayer:Predict(t)
    local gravity = client.GetConVar("sv_gravity")
    local stepSize = self:GetPropFloat("localdata", "m_flStepSize")
    if not gravity or not stepSize then return nil end

    local vel = self:EstimateAbsVelocity()
    local pos = self:GetAbsOrigin()
    local step = Vector3(0, 0, stepSize)

    local predTable = {
        [0] = {p = pos, v = vel, g = self:IsOnGround()}
    }
    local interval = globals.TickInterval()
    for i = 1, t do
        local last = predTable[i - 1]
        local time = i * interval

        local predVel = vel * time
        local predGrav = Vector3(0, 0, gravity * -0.5) * (time ^ 2)
        local predPos = pos + predVel + predGrav

        -- Check if the position is on ground
        local onGround = false
        local trace = engine.TraceHull(last.p + step, predPos, Vector3(-5, -5, -5), Vector3(5, 5, 5), MASK_SOLID)
        if trace.fraction < 1 then
            -- Check if the step is too big | TODO: Calculate the new velocity
            local stepDist = trace.endpos.z - last.p.z
            if math.floor(stepDist) >= stepSize - 1 then
                predPos = last.p
                onGround = true
            else
                predPos = trace.endpos
                onGround = true
            end
        end

        predTable[i] = {
            p = predPos,
            v = predVel,
            g = onGround
        }
    end

    return predTable
end

return WPlayer
