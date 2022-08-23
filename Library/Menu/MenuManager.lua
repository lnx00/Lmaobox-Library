---@class MenuManager
---@field private _Menus Menu[]
---@field public Menu Menu
local MenuManager = {
    _Menus = { },

    Menu = require("Library/Menu/Menu")
}

---@param name string
---@return Menu
function MenuManager.Create(name)
    local newMenu = MenuManager.Menu.new(name)
    table.insert(MenuManager._Menus, newMenu)

    return newMenu
end

---@param menu Menu
function MenuManager.Remove(menu)
    for i, v in pairs(MenuManager._Menus) do
        if v == menu then
            table.remove(MenuManager._Menus, i)
            break
        end
    end
end

function MenuManager._OnDraw()
    for i, menu in pairs(MenuManager._Menus) do
        menu:_OnDraw()
    end
end

return MenuManager