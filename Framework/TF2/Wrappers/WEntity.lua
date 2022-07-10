--[[
    Wrapper Class for Entities
]]

local WEntity = {
    Entity = nil
}
WEntity.__index = WEntity

--[[ Constructors ]]

-- Creates a WEntity from a given native Entity
function WEntity.FromEntity(entity)
    local self = setmetatable({ }, WEntity)
    self.Entity = entity

    return self
end

--[[ Wrapper functions ]]

function WEntity:Unwrap()
    return self.Entity
end

-- Returns the position of the hitbox as a Vector3
function WEntity:GetHitboxPos(nHitbox)
    local hitbox = self.Entity:GetHitboxes()[nHitbox]
    if not hitbox then return end

    return (hitbox[1] + hitbox[2]) * 0.5
end

return WEntity