EulerAngles = {}
EulerAngles.__index = EulerAngles

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

    self.x = self.pitch
    self.y = self.yaw
    self.z = self.roll

    return self
end

function EulerAngles:Forward()
    local pitch = math.rad(self.pitch)
    local yaw = math.rad(self.yaw)

    local x = math.cos(pitch) * math.cos(yaw)
    local y = math.cos(pitch) * math.sin(yaw)
    local z = math.sin(pitch)

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
