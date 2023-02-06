--[[
    Wrapper Class for Entities
]]

---@type Helpers
local Helpers = require("Library/TF2/Helpers")

---@class WEntity : Entity
---@field private Entity Entity|nil
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

---@param b WEntity|Entity
function WEntity:Equals(b)
    return self:GetIndex() == b:GetIndex()
end

---@return number
function WEntity:GetSimulationTime()
    return self:GetPropFloat("m_flSimulationTime")
end

-- Returns whether the entity can be seen from the given entity
---@param fromEntity Entity
function WEntity:IsVisible(fromEntity)
    return Helpers.VisPos(self, fromEntity:GetAbsOrigin(), self:GetAbsOrigin())
end

return WEntity
