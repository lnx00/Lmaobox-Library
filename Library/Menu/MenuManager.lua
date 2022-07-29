local Menu = require(LIB_PATH .. "Menu/Menu")

---@class MenuManager
local MenuManager = {
    Window = require(LIB_PATH .. "Menu/Components/Window"),
    Panel = require(LIB_PATH .. "Menu/Components/Panel"),

    Menus = { },
}

-- Creates a new menu with the given name
---@param name string
function MenuManager.new(name)
    local menu = Menu.new(name)
    MenuManager.Menu[name] = menu
    return menu
end

-- Removes the given menu
---@param name string
function MenuManager.Remove(name)
    MenuManager.Menus[name] = nil
end

-- Draw all menus
function MenuManager.Draw()
    for _, menu in pairs(MenuManager.Menus) do
        menu:Draw()
    end
end

-- Register callbacks for drawing
callbacks.Unregister("Draw", "Draw_MenuManager")
callbacks.Register("Draw", "Draw_MenuManager", MenuManager.Draw)

return MenuManager