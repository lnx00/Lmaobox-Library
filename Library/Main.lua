--[[ Globals ]]

-- Get the current folder for relative require
LIB_PATH = debug.getinfo(1, "S").source:sub(2):match("(.*/)")

--[[ Main ]]

---@class Main
---@field public TF2 TF2
local Main = {
    TF2 = require(LIB_PATH .. "TF2/TF2"),
    UI = require(LIB_PATH .. "UI/UI"),
    Utils = require(LIB_PATH .. "Utils/Utils"),
    Enums = require(LIB_PATH .. "Enums"),
}

---@return number
function Main.GetVersion()
    return 0.2
end

--[[ Callbacks ]]

---@param userCmd UserCmd
local function OnCreateMove(userCmd)
    Main.TF2._OnCreateMove(userCmd)
end

local function OnDraw()
    Main.TF2._OnDraw()
end

callbacks.Unregister("CreateMove", "LBL_CreateMove")
callbacks.Register("CreateMove", "LBL_CreateMove", OnCreateMove)

callbacks.Unregister("Draw", "LBL_Draw")
callbacks.Register("Draw", "LBL_Draw", OnDraw)

--[[ Debugging ]]

-- Unloads the entire library. Useful for debugging
function UnloadLib()
    for name, pck in pairs(package.loaded) do
        if name:find("Lmaobox-Library", 1, true) then
            printc(195, 55, 20, 255, "Unloading: " .. name)
            package.loaded[name] = nil
        end
    end

    printc(230, 65, 25, 255, "Lmaobox-Library unloaded.")
end

printc(75, 210, 55, 255, "Lmaobox-Library v" .. Main.GetVersion() .. " loaded.")
return Main