local WPlayer = { }
WPlayer.__index = WPlayer

-- Creates a WPlayer from a given native Entity
function WPlayer.FromEntity(entity)
    local this = setmetatable({ }, WPlayer)
    this.Entity = entity

    return this
end

-- Creates a WPlayer from a given WEntity
function WPlayer.FromWEntity(wEntity)
    local this = setmetatable({ }, WPlayer)
    this.Entity = wEntity.Entity

    return this
end

return WPlayer