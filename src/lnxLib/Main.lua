--[[
    lnxLib - An utility library for Lmaobox
]]

-- Globals
require("lnxLib/Global/Global")

--[[ Main ]]

---@class lnxLib
---@field public TF2 TF2
---@field public UI UI
---@field public Utils Utils
local lnxLib = {
    TF2 = require("lnxLib/TF2/TF2"),
    UI = require("lnxLib/UI/UI"),
    Utils = require("lnxLib/Utils/Utils"),
}

---@return number
function lnxLib.GetVersion()
    return 0.976
end

--[[ Debugging ]]

-- Unloads the entire library. Useful for debugging
function UnloadLib()
    lnxLib.Utils.UnloadPackages("lnxLib")
    lnxLib.Utils.UnloadPackages("LNXlib")
end

-- Library loaded
printc(75, 210, 55, 255, string.format("lnxLib Loaded (v%.3f)", lnxLib.GetVersion()))
lnxLib.UI.Notify.Simple("lnxLib loaded", string.format("Version: %.3f", lnxLib.GetVersion()))

Internal.Cleanup()
return lnxLib
