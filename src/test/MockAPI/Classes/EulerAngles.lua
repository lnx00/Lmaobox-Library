EulerAngles = {}
EulerAngles.__index = EulerAngles
EulerAngles.__index.x = EulerAngles.__index.pitch
EulerAngles.__index.y = EulerAngles.__index.yaw
EulerAngles.__index.z = EulerAngles.__index.roll

local function normalize(angle)
    if angle > 180 then
        return angle - 360
    elseif angle < -180 then
        return angle + 360
    end

    return angle
end

setmetatable(EulerAngles, {
    __call = function(cls, ...)
        return cls.new(...)
    end,
})

function EulerAngles.new(pitch, yaw, roll)
    local self = setmetatable({}, EulerAngles)

    self.pitch = pitch or 0
    self.yaw = yaw or 0
    self.roll = roll or 0

    return self
end

function EulerAngles:Unpack()
    return self.pitch, self.yaw, self.roll
end

function EulerAngles:Clear()
    self.pitch = 0
    self.yaw = 0
    self.roll = 0
end

function EulerAngles:Normalize()
    self.pitch = normalize(self.pitch)
    self.yaw = normalize(self.yaw)
    self.roll = normalize(self.roll)
end

function EulerAngles:Forward()
    local pitch = math.rad(self.pitch)
    local yaw = math.rad(self.yaw)

    local x = math.cos(pitch) * math.cos(yaw)
    local y = math.cos(pitch) * math.sin(yaw)
    local z = math.sin(pitch)

    return Vector3(x, y, z)
end

function EulerAngles:Right()
    local yaw = math.rad(self.yaw)

    local x = math.sin(yaw)
    local y = -math.cos(yaw)

    return Vector3(x, y, 0)
end

function EulerAngles:Up()
    local pitch = math.rad(self.pitch)
    local yaw = math.rad(self.yaw)

    local x = -math.sin(pitch) * math.cos(yaw)
    local y = -math.sin(pitch) * math.sin(yaw)
    local z = math.cos(pitch)

    return Vector3(x, y, z)
end

function EulerAngles:__tostring()
    return string.format("EulerAngles(%f, %f, %f)", self.pitch, self.yaw, self.roll)
end

function EulerAngles:__eq(other)
    return self.pitch == other.pitch and self.yaw == other.yaw and self.roll == other.roll
end

function EulerAngles:__add(other)
    return EulerAngles(self.pitch + other.pitch, self.yaw + other.yaw, self.roll + other.roll)
end

function EulerAngles:__sub(other)
    return EulerAngles(self.pitch - other.pitch, self.yaw - other.yaw, self.roll - other.roll)
end

function EulerAngles:__mul(other)
    if type(other) == "number" then
        return EulerAngles(self.pitch * other, self.yaw * other, self.roll * other)
    else
        return EulerAngles(self.pitch * other.pitch, self.yaw * other.yaw, self.roll * other.roll)
    end
end

function EulerAngles:__div(other)
    if type(other) == "number" then
        return EulerAngles(self.pitch / other, self.yaw / other, self.roll / other)
    else
        return EulerAngles(self.pitch / other.pitch, self.yaw / other.yaw, self.roll / other.roll)
    end
end

function EulerAngles:__unm()
    return EulerAngles(-self.pitch, -self.yaw, -self.roll)
end
