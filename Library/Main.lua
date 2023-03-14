--[[
    lnxLib - An utility library for Lmaobox
]]

-- Globals
require("Library/Global/Global")

--[[ Main ]]

---@class lnxLib
---@field public TF2 TF2
---@field public UI UI
---@field public Utils Utils
local lnxLib = {
    TF2 = require("Library/TF2/TF2"),
    UI = require("Library/UI/UI"),
    Utils = require("Library/Utils/Utils"),
}

---@return number
function lnxLib.GetVersion()
    return 0.967
end

--[[ Debugging ]]

-- Unloads the entire library. Useful for debugging
function UnloadLib()
    lnxLib.Utils.UnloadPackages("lnxLib")
end

-- Library loaded
printc(75, 210, 55, 255, string.format("lnxLib Loaded (v%.3f)", lnxLib.GetVersion()))
lnxLib.UI.Notify.Simple("lnxLib loaded", string.format("Version: %.3f", lnxLib.GetVersion()))

Internal.Cleanup()
return lnxLib
