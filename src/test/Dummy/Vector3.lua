Vector3 = {}
Vector3.__index = Vector3

setmetatable(Vector3, {
    __call = function(cls, ...)
        return cls.new(...)
    end,
})

function Vector3.new(x, y, z)
    local self = setmetatable({}, Vector3)
    self.x = x or 0
    self.y = y or 0
    self.z = z or 0
    return self
end

function Vector3:Length()
    return math.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
end

function Vector3:Length2D()
    return math.sqrt(self.x * self.x + self.y * self.y)
end

function Vector3:LengthSqr()
    return self.x * self.x + self.y * self.y + self.z * self.z
end

function Vector3:Dot(other)
    return self.x * other.x + self.y * other.y + self.z * other.z
end

function Vector3:__tostring()
    return string.format("Vector3(%f, %f, %f)", self.x, self.y, self.z)
end

function Vector3:__eq(other)
    return self.x == other.x and self.y == other.y and self.z == other.z
end

function Vector3:__add(other)
    return Vector3(self.x + other.x, self.y + other.y, self.z + other.z)
end

function Vector3:__sub(other)
    return Vector3(self.x - other.x, self.y - other.y, self.z - other.z)
end

function Vector3:__mul(other)
    if type(other) == "number" then
        return Vector3(self.x * other, self.y * other, self.z * other)
    else
        return Vector3(self.x * other.x, self.y * other.y, self.z * other.z)
    end
end

function Vector3:__div(other)
    if type(other) == "number" then
        return Vector3(self.x / other, self.y / other, self.z / other)
    else
        return Vector3(self.x / other.x, self.y / other.y, self.z / other.z)
    end
end

function Vector3:__unm()
    return Vector3(-self.x, -self.y, -self.z)
end
