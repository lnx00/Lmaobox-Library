--[[
    Movement prediction
]]

---@alias PredictionResult { pos : Vector3[], vel: Vector3[], onGround: boolean[] }

---@class Prediction
---@field private _Result PredictionResult
local Prediction = {
    _Result = { pos = {}, vel = {}, onGround = {} }
}
Prediction.__index = Prediction
setmetatable(Prediction, Prediction)

local _vUp = Vector3(0, 0, 1)
local _hitbox = { Vector3(-20, -20, 0), Vector3(20, 20, 80) }

-- Creates a new prediction instance
---@return Prediction
function Prediction.new()
    local self = setmetatable({}, Prediction)
    self._Result = { pos = {}, vel = {}, onGround = {} }

    return self
end

---@return PredictionResult
function Prediction:Result()
    --return table.readOnly(self._Result)
    return self._Result
end

---@param _out PredictionResult
---@param player WPlayer
---@param t integer
---@param d number?
local function Predict(_out, player, t, d)
    local gravity = client.GetConVar("sv_gravity")
    local stepSize = player:GetPropFloat("localdata", "m_flStepSize")
    if not gravity or not stepSize then return nil end

    local vStep = Vector3(0, 0, stepSize)
    local shouldHitEntity = function (ent, _) return ent:GetIndex() ~= player:GetIndex() end

    -- Add the current record
    _out.pos[0], _out.vel[0], _out.onGround[0] = player:GetAbsOrigin(), player:EstimateAbsVelocity(), player:IsOnGround()

    -- Perform the prediction
    for i = 1, t do
        local lastP, lastV, lastG = _out.pos[i - 1], _out.vel[i - 1], _out.onGround[i - 1]

        local pos = lastP + lastV * globals.TickInterval()
        local vel = lastV
        local onGround = lastG

        -- Apply deviation
        if d then
            local ang = vel:Angles()
            ang.y = ang.y + d
            vel = ang:Forward() * vel:Length()
        end

        --[[ Forward collision ]]

        local wallTrace = engine.TraceHull(lastP + vStep, pos + vStep, _hitbox[1], _hitbox[2], MASK_PLAYERSOLID, shouldHitEntity)
        --DrawLine(last.p + vStep, pos + vStep)
        if wallTrace.fraction < 1 then
            -- We'll collide
            local normal = wallTrace.plane
            local angle = math.deg(math.acos(normal:Dot(_vUp)))

            -- Check the wall angle
            if angle > 55 then
                -- The wall is too steep, we'll collide
                local dot = vel:Dot(normal)
                vel = vel - normal * dot
            end

            pos.x, pos.y = wallTrace.endpos.x, wallTrace.endpos.y
        end

        --[[ Ground collision ]]

        -- Don't step down if we're in-air
        local downStep = vStep
        if not onGround then downStep = Vector3() end

        local groundTrace = engine.TraceHull(pos + vStep, pos - downStep, _hitbox[1], _hitbox[2], MASK_PLAYERSOLID, shouldHitEntity)
        --DrawLine(pos + vStep, pos - downStep)
        if groundTrace.fraction < 1 then
            -- We'll hit the ground
            local normal = groundTrace.plane
            local angle = math.deg(math.acos(normal:Dot(_vUp)))

            -- Check the ground angle
            if angle < 45 then
                pos = groundTrace.endpos
                onGround = true
            elseif angle < 55 then
                -- The ground is too steep, we'll slide [TODO]
                vel.x, vel.y, vel.z = 0, 0, 0
                onGround = false
            else
                -- The ground is too steep, we'll collide
                local dot = vel:Dot(normal)
                vel = vel - normal * dot
                onGround = true
            end

            -- Don't apply gravity if we're on the ground
            if onGround then vel.z = 0 end
        else
            -- We're in the air
            onGround = false
        end

        -- Gravity
        if not onGround then
            vel.z = vel.z - gravity * globals.TickInterval()
        end

        -- Add the prediction record
        _out.pos[i], _out.vel[i], _out.onGround[i] = pos, vel, onGround
    end

    --return _out
end

-- Performs a prediction
---@param player WPlayer
---@param ticks integer
---@param deviation number?
function Prediction:Perform(player, ticks, deviation)
    Predict(self._Result, player, ticks, deviation)
end

return Prediction
