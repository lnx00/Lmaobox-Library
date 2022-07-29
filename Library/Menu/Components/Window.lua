local Component = require(LIB_PATH .. "Menu/Components/Component")

---@class Window
local Window = {
    Menu = nil,
    Location = { }
}
Window.__index = Window
setmetatable(Window, Component)

---@param menu Menu
---@param title string
function Window.new(menu, title)
    local self = setmetatable({ }, Window)
    self.Menu = menu
    self.Location = { }

    return self
end

function Window:Draw()
    if not self.Visible then return end
end

return Window