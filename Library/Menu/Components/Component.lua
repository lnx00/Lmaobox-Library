---@class Component
---@field public ID string
---@field public Visible boolean
local Component = {
    ID = "",
    Visible = true
}
Component.__index = Component
setmetatable(Component, Component)

---@param data table
---@return Component
function Component.new(data)
    assert(type(data) == "table", "Component.new: data is not a table")

    ---@type self
    local self = setmetatable({ }, Component)
    self.ID = data.ID or ""
    self.Visible = data.Visible == true

    return self
end

---@param window Window
---@return number, number
function Component:Render(window)
    if self.Visible then return 0, 0 end
end

return Component