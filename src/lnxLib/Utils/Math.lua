--[[
    Math Functions
]]

---@class Math
local Math = {}

local M_RADPI = 180 / math.pi

local function isNaN(x) return x ~= x end

-- Normalizes an angle to be between -180 and 180
---@param angle number
---@return number
function Math.NormalizeAngle(angle)
    if angle > 180 then
        angle = angle - 360
    elseif angle < -180 then
        angle = angle + 360
    end

    return angle
end

-- Remaps a value from one range to another
---@param val number
---@param A number
---@param B number
---@param C number
---@param D number
---@return number
function Math.RemapValClamped(val, A, B, C, D)
    if A == B then
        return val >= B and D or C
    end

    local cVal = (val - A) / (B - A)
    cVal = math.clamp(cVal, 0, 1)

    return C + (D - C) * cVal
end

-- Calculates the angle between two vectors
---@param source Vector3
---@param dest Vector3
---@return EulerAngles angles
function Math.PositionAngles(source, dest)
    local delta = source - dest

    local pitch = math.atan(delta.z / delta:Length2D()) * M_RADPI
    local yaw = math.atan(delta.y / delta.x) * M_RADPI

    if delta.x >= 0 then
        yaw = yaw + 180
    end

    if isNaN(pitch) then pitch = 0 end
    if isNaN(yaw) then yaw = 0 end

    return EulerAngles(pitch, yaw, 0)
end

-- Calculates the FOV between two angles
---@param vFrom EulerAngles
---@param vTo EulerAngles
---@return number fov
function Math.AngleFov(vFrom, vTo)
    local vSrc = vFrom:Forward()
    local vDst = vTo:Forward()
    
    local fov = math.deg(math.acos(vDst:Dot(vSrc) / vDst:LengthSqr()))
    if isNaN(fov) then fov = 0 end

    return fov
end

---@param origin Vector3
---@param target Vector3
---@param speed number
---@param gravity number
---@return EulerAngles?
function Math.SolveProjectile(origin, target, speed, gravity)
    local _, sv_gravity = client.GetConVar("sv_gravity")
    local v = target - origin
    local dx = v:Length2D()
    local dy = v.z
    local v0 = speed

    local g = sv_gravity * gravity
    if g == 0 then
        -- Straight line
        return Math.PositionAngles(origin, target)
    else
        -- Ballistic arc
        local root = v0 * v0 * v0 * v0 - g * (g * dx * dx + 2 * dy * v0 * v0)
        if root < 0 then return nil end

        local pitch = math.atan((v0 * v0 - math.sqrt(root)) / (g * dx))
        local yaw = math.atan(v.y, v.x)

        if isNaN(pitch) or isNaN(yaw) then return nil end

        return EulerAngles(pitch * -M_RADPI, yaw * M_RADPI, 0)
    end
end

return Math
