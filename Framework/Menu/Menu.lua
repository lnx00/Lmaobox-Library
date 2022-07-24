---@class Menu
local Menu = {
    Enabled = true,
    Windows = { }
}
Menu.__index = Menu
setmetatable(Menu, Menu)

function Menu.new()
    local self = setmetatable({ }, Menu)
    self.Enabled = true
    self.Windows = { }

    return self
end

-- Draw all windows of this menu
function Menu:Draw()
    for _, window in pairs(self.Windows) do
        window:Draw()
    end
end

return Menu