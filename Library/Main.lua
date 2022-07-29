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
}

---@return number
function Main:GetVersion()
    return 0.1
end

--[[ Callbacks ]]

---@param userCmd UserCmd
local function OnCreateMove(userCmd)
    Main.TF2._OnCreateMove(userCmd)
end

local function OnDraw()

end

callbacks.Unregister("CreateMove", "LBL_CreateMove")
callbacks.Register("CreateMove", "LBL_CreateMove", OnCreateMove)

callbacks.Unregister("Draw", "LBL_Draw")
callbacks.Register("Draw", OnDraw)

return Main