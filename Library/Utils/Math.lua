--[[
    Math Functions
]]

---@class Math
local Math = {}

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

return Math
