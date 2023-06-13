---@class Prediction
local Prediction = {}

-- Predict the position of a player
---@param player WPlayer
---@param t integer
---@param d number?
---@return { pos : Vector3[], vel: Vector3[], onGround: boolean[] }?
function Prediction.Player(player, t, d)
    local gravity = client.GetConVar("sv_gravity")
    local stepSize = player:GetPropFloat("localdata", "m_flStepSize")
    if not gravity or not stepSize then return nil end

    local vUp = Vector3(0, 0, 1)
    local vHitbox = { Vector3(-20, -20, 0), Vector3(20, 20, 80) }
    local vStep = Vector3(0, 0, stepSize)
    local idx = player:GetIndex()
    local shouldHitEntity = function (e, _) return false end

    -- Add the current record
    local _out = {
        pos = { [0] = player:GetAbsOrigin() },
        vel = { [0] = player:EstimateAbsVelocity() },
        onGround = { [0] = player:IsOnGround() }
    }

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

        local wallTrace = engine.TraceHull(lastP + vStep, pos + vStep, vHitbox[1], vHitbox[2], MASK_PLAYERSOLID, shouldHitEntity)
        --DrawLine(last.p + vStep, pos + vStep)
        if wallTrace.fraction < 1 then
            -- We'll collide
            local normal = wallTrace.plane
            local angle = math.deg(math.acos(normal:Dot(vUp)))

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

        local groundTrace = engine.TraceHull(pos + vStep, pos - downStep, vHitbox[1], vHitbox[2], MASK_PLAYERSOLID, shouldHitEntity)
        --DrawLine(pos + vStep, pos - downStep)
        if groundTrace.fraction < 1 then
            -- We'll hit the ground
            local normal = groundTrace.plane
            local angle = math.deg(math.acos(normal:Dot(vUp)))

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

    --shouldHitEntity = nil
    return _out
end

-- Predicts the position of a projectile
---@param player WPlayer
---@param speed number
---@param gravity number
---@param t integer
---@return { pos : Vector3[], vel: Vector3[] }?
function Prediction.Projectile(player, speed, gravity, t)
    local shootPos = player:GetEyePos()
    local shootAngles = player:GetEyeAngles()
    local shootDir = shootAngles:Forward()
    local _, sv_gravity = client.GetConVar("sv_gravity")
    gravity = sv_gravity * gravity

    local _out = {
        pos = { [0] = shootPos },
        vel = { [0] = shootDir * speed }
    }

    for i = 1, t do
        local lastP, lastV = _out.pos[i - 1], _out.vel[i - 1]

        local pos = lastP + lastV * globals.TickInterval()
        local vel = lastV

        -- Apply gravity
        vel.z = vel.z - gravity * globals.TickInterval()

        -- Add the prediction record
        _out.pos[i], _out.vel[i] = pos, vel
    end

    return _out
end

return Prediction
