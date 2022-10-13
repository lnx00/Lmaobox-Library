--[[
    Wrapper Class for Entities
]]

---@type Helpers
local Helpers = require("Library/TF2/Helpers")

---@class WEntity : Entity
---@field private Entity Entity
local WEntity = {
    Entity = nil
}
WEntity.__index = WEntity
setmetatable(WEntity, {
    __index = function(self, key, ...)
        return function(self, ...)
            local entity = rawget(self, "Entity")
            return entity[key](entity, ...)
        end
    end
})

--[[ Constructors ]]

-- Creates a WEntity from a given native Entity
---@param entity Entity
---@return WEntity
function WEntity.FromEntity(entity)
    ---@type self
    local self = setmetatable({ }, WEntity)
    self.Entity = entity

    return self
end

-- Returns the native entity
---@return Entity
function WEntity:Unwrap()
    return self.Entity
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