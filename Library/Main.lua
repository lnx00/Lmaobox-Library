-- Globals
require("Library/Global/Global")

--[[ Main ]]

---@class LNXlib
---@field public TF2 TF2
---@field public UI UI
---@field public Utils Utils
---@field public Enums Enums
local LNXlib = {
    TF2 = require("Library/TF2/TF2"),
    UI = require("Library/UI/UI"),
    Utils = require("Library/Utils/Utils"),
    Enums = require("Library/Enums"),
}

---@return number
function LNXlib.GetVersion()
    return 0.80
end

--[[ Callbacks ]]

---@param userCmd UserCmd
local function OnCreateMove(userCmd)
    LNXlib.TF2._OnCreateMove(userCmd)
end

local function OnDraw()
    LNXlib.TF2._OnDraw()
    LNXlib.UI._OnDraw()
end

callbacks.Unregister("CreateMove", "LBL_CreateMove")
callbacks.Register("CreateMove", "LBL_CreateMove", OnCreateMove)

callbacks.Unregister("Draw", "LBL_Draw")
callbacks.Register("Draw", "LBL_Draw", OnDraw)

--[[ Debugging ]]

-- Unloads the entire library. Useful for debugging
function UnloadLib()
    for name, _ in pairs(package.loaded) do
        if name:find("Lmaobox-Library", 1, true) or name:find("LNX-Library", 1, true) then
            printc(195, 55, 20, 255, "Unloading: " .. name)
            package.loaded[name] = nil
        end
    end

    printc(230, 65, 25, 255, "Lmaobox-Library unloaded.")
end

-- Library loaded
printc(75, 210, 55, 255, "LNXlib v" .. LNXlib.GetVersion() .. " loaded.")
LNXlib.UI.Notify.Simple("Library Loaded", "Version: " .. LNXlib.GetVersion())

return LNXlib