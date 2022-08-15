local Window = require("Library/Menu/Components/Window")

---@type Menu[]
local MenuList = {}

---@class Menu
---@field public ID string
---@field public Windows Window[]
local Menu = {
    ID = "",
    Windows = { }
}
Menu.__index = Menu
setmetatable(Menu, Menu)

---@param id string
---@return Menu
function Menu.new(id)
    ---@type self
    local self = setmetatable({ }, Menu)
    self.ID = id

    MenuList[id] = self
    return self
end

function Menu:Remove()
    MenuList[self.ID] = nil
end

---@param data table
---@return Window
function Menu:CreateWindow(data)
    assert(type(data) == "table", "Menu:CreateWindow: data must be a table")

    local window = Window.new(data)
    table.insert(self.Windows, window)

    return window
end

function Menu:Render()
    for i, window in pairs(self.Windows) do
        window:Render()
    end
end

function Menu._OnDraw()
    for i, menu in pairs(MenuList) do
        menu:Render()
    end
end

return Menu