--[[
    Math Functions
]]

---@class Math
local Math = {}

local M_RADPI = 180 / math.pi

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
    local fHyp = delta:Length2D()

    local pitch = math.atan(delta.z / delta:Length2D()) * M_RADPI
    local yaw = math.atan(delta.y / delta.x) * M_RADPI

    if delta.x >= 0 then
        yaw = yaw + 180
    end

    return EulerAngles(pitch, yaw, 0)
end

-- Calculates the FOV between two angles
---@param vFrom EulerAngles
---@param vTo EulerAngles
---@return number fov
function Math.AngleFov(vFrom, vTo)
    local vSrc = vFrom:Forward()
    local vDst = vTo:Forward()
    
    return math.deg(math.acos(vSrc:Dot(vDst) / vDst:LengthSqr()))
end

return Math
