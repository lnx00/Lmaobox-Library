local WEntity = { }
WEntity.__index = WEntity

-- Creates a WEntity from a given native Entity
function WEntity.FromEntity(entity)
    local self = setmetatable({ }, WEntity)
    self.Entity = entity

    return self
end

return WEntity