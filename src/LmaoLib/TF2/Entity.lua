--[[
    Wrapper Class for Entities
]]

---@type Helpers
local Helpers = require("LmaoLib/TF2/Helpers")

---@class EntityUtils
---@field private Entity Entity?
local EntityUtils = {}

-- Returns if the entities are equal (same index)
---@param ent Entity
---@param other Entity
function EntityUtils.Equals(ent, other)
    return ent:GetIndex() == other:GetIndex()
end

-- Returns the distance to the given entity
---@param ent Entity
---@param other Entity
function EntityUtils.DistTo(ent, other)
    return (other:GetAbsOrigin() - ent:GetAbsOrigin()):Length()
end

---@param ent Entity
---@return number
function EntityUtils.GetSimulationTime(ent)
    return ent:GetPropFloat("m_flSimulationTime")
end

---@param ent Entity
---@param t number
---@return Vector3
function EntityUtils.Extrapolate(ent, t)
    return ent:GetAbsOrigin() + ent:EstimateAbsVelocity() * t
end

-- Returns whether the entity can be seen from the given entity
---@param ent Entity
---@param fromEntity Entity
function EntityUtils.IsVisible(ent, fromEntity)
    return Helpers.VisPos(ent, fromEntity:GetAbsOrigin(), ent:GetAbsOrigin())
end

return EntityUtils
