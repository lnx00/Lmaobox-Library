--[[
    Wrapper Class for Entities
]]

---@type Helpers
local Helpers = require("lnxLib/TF2/Helpers")

---@class WEntity : Entity
---@field private Entity Entity?
local WEntity = {
    Entity = nil
}
WEntity.__index = WEntity
setmetatable(WEntity, {
    __index = function(self, key, ...)
        return function(t, ...)
            local entity = rawget(t, "Entity")
            return entity[key](entity, ...)
        end
    end
})

--[[ Constructors ]]

-- Creates a WEntity from a given native Entity
---@param entity Entity
---@return WEntity
function WEntity.FromEntity(entity)
    assert(entity, "WEntity.FromEntity: entity is nil")

    local self = setmetatable({}, WEntity)
    self:SetEntity(entity)

    return self
end

-- Sets the base entity
---@param entity Entity
function WEntity:SetEntity(entity)
    self.Entity = entity
end

-- Returns the native entity
---@return Entity
function WEntity:Unwrap()
    return self.Entity
end

-- Returns if the entities are equal (same index)
---@param other WEntity|Entity
function WEntity:Equals(other)
    return self:GetIndex() == other:GetIndex()
end

-- Returns the distance to the given entity
---@param other WEntity|Entity
function WEntity:DistTo(other)
    return (other:GetAbsOrigin() - self:GetAbsOrigin()):Length()
end

---@return number
function WEntity:GetSimulationTime()
    return self:GetPropFloat("m_flSimulationTime")
end

---@param t number
---@return Vector3
function WEntity:Extrapolate(t)
    return self:GetAbsOrigin() + self:EstimateAbsVelocity() * t
end

-- Returns whether the entity can be seen from the given entity
---@param fromEntity Entity
function WEntity:IsVisible(fromEntity)
    return Helpers.VisPos(self, fromEntity:GetAbsOrigin(), self:GetAbsOrigin())
end

return WEntity
