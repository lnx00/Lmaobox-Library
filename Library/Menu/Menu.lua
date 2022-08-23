local Window = require("Library/Menu/Window")

---@class Menu
---@field public Windows Window[]
local Menu = {
    Windows = { }
}
Menu.__index = Menu
setmetatable(Menu, Menu)

---@param name string
---@return Menu
function Menu.new(name)
    ---@type self
    local self = setmetatable({ }, Menu)
    self.Windows = { }

    return self
end

function Menu:AddWindow(data)
    local newWindow = Window.new(self, data)
    table.insert(self.Windows, newWindow)

    return newWindow
end

function Menu:RemoveWindow(window)
    for i, v in pairs(self.Windows) do
        if v == window then
            table.remove(self.Windows, i)
            break
        end
    end
end

function Menu:Clear()
    self.Windows = { }
end

function Menu:_OnDraw()
    for i, window in pairs(self.Windows) do
        window:Render()
    end
end

return Menu