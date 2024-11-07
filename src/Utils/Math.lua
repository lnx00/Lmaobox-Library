--[[
    Math Functions
]]

---@class Math
local mathx = {}

local M_RADPI = 180 / math.pi

local function isNaN(x) return x ~= x end

-- Normalizes an angle to be between -180 and 180
---@param angle number
---@return number
function mathx.norm_angle(angle)
    angle = angle % 360
    if angle > 180 then
        angle = angle - 360
    end

    return angle
end

-- Remaps a value x from one range to another
---@param x number
---@param a number
---@param b number
---@param c number
---@param d number
---@return number
function mathx.remap_clamp(x, a, b, c, d)
    if a == b then
        return x >= b and d or c
    end

    local cVal = (x - a) / (b - a)
    cVal = math.clamp(cVal, 0, 1)

    return c + (d - c) * cVal
end

-- Calculates the angle between two vectors
---@param a Vector3
---@param b Vector3
---@return EulerAngles angles
function mathx.vec_angle(a, b)
    local delta = a - b

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
function mathx.angle_fov(vFrom, vTo)
    local vSrc = vFrom:Forward()
    local vDst = vTo:Forward()
    
    local fov = math.deg(math.acos(vDst:Dot(vSrc) / vDst:LengthSqr()))
    if isNaN(fov) then fov = 0 end

    return fov
end

-- Calculates the angle needed to hit a target with a projectile
---@param origin Vector3
---@param dest Vector3
---@param speed number
---@param gravity number
---@return { angles: EulerAngles, time: number }?
function mathx.solve_projectile(origin, dest, speed, gravity)
    local _, sv_gravity = client.GetConVar("sv_gravity")
    local v = dest - origin
    local v0 = speed

    local g = sv_gravity * gravity
    if g == 0 then
        -- Straight line
        local angles = mathx.vec_angle(origin, dest)
        local time = v:Length() / v0
        return { angles = angles, time = time }
    else
        -- Ballistic arc
        local dx = v:Length2D()
        local dy = v.z
        local root = v0 * v0 * v0 * v0 - g * (g * dx * dx + 2 * dy * v0 * v0)
        if root < 0 then return nil end

        local pitch = math.atan((v0 * v0 - math.sqrt(root)) / (g * dx))
        local yaw = math.atan(v.y, v.x)

        if isNaN(pitch) or isNaN(yaw) then return nil end

        local angles = EulerAngles(pitch * -M_RADPI, yaw * M_RADPI)
        local time =  dx / (math.cos(pitch) * v0)
        return { angles = angles, time = time }
    end
end

return mathx
