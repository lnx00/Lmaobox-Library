---@class Component
local Component = {
    Visible = true,
    Parent = nil,
    Childs = {}
}
Component.__index = Component
setmetatable(Component, Component)

function Component.new()
    local self = setmetatable({ }, Component)
    self.Visible = true
    self.Parent = nil
    self.Childs = { }

    return self
end

return Component