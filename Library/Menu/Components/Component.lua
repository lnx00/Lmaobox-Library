---@class Component
---@field public Visible boolean
---@field public Parent Component
---@field public Children Component[]
local Component = {
    Visible = true,
    Parent = nil,
    Childs = {}
}
Component.__index = Component
setmetatable(Component, Component)

---@return Component
function Component.new()
    ---@type self
    local self = setmetatable({ }, Component)
    self.Visible = true
    self.Parent = nil
    self.Childs = { }

    return self
end

return Component