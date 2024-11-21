--[[
    Wrapper Class for Entities
]]

---@type Helpers
local helpers = require("src/TF2/Helpers")

---@class EntityUtils
---@field private Entity Entity?
local entityutil = {}

-- Returns if the entities are equal (same index)
---@param ent Entity
---@param other Entity
function entityutil.equals(ent, other)
    return ent:GetIndex() == other:GetIndex()
end

-- Returns the distance to the given entity
---@param ent Entity
---@param other Entity
function entityutil.dist(ent, other)
    return (other:GetAbsOrigin() - ent:GetAbsOrigin()):Length()
end

---@param ent Entity
---@return number
function entityutil.sim_time(ent)
    return ent:GetPropFloat("m_flSimulationTime")
end

---@param ent Entity
---@param t number
---@return Vector3
function entityutil.extrapolate(ent, t)
    return ent:GetAbsOrigin() + ent:EstimateAbsVelocity() * t
end

-- Returns whether the entity can be seen from the given entity
---@param ent Entity
---@param fromEntity Entity
function entityutil.visible(ent, fromEntity)
    return helpers.can_see(ent, fromEntity:GetAbsOrigin(), ent:GetAbsOrigin())
end

return entityutil
