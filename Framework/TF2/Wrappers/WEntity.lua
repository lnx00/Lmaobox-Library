--[[
    Wrapper Class for Entities
]]

---@class WEntity
---@field public Entity Entity
local WEntity = { }
WEntity.__index = WEntity

--[[ Constructors ]]

-- Creates a WEntity from a given native Entity
---@param entity any
---@return WEntity
function WEntity.FromEntity(entity)
    ---@type self
    local self = setmetatable({ }, WEntity)
    self.Entity = entity

    return self
end

--[[ Wrapper functions ]]

-- Returns the native base entity
function WEntity:Unwrap()
    return self.Entity
end

-- Returns the position of the hitbox as a Vector3
---@param hitbox number
function WEntity:GetHitboxPos(hitbox)
    local hitbox = self.Entity:GetHitboxes()[hitbox]
    if not hitbox then return end

    return (hitbox[1] + hitbox[2]) * 0.5
end

return WEntity