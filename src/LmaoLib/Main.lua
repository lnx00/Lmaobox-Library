--[[
    LmaoLib - An utility library for Lmaobox
]]

-- Globals
require("LmaoLib/Global/Global")

--[[ Main ]]

---@class LmaoLib
---@field public TF2 TF2
---@field public UI UI
---@field public Utils Utils
local LmaoLib = {
    TF2 = require("LmaoLib/TF2/TF2"),
    UI = require("LmaoLib/UI/UI"),
    Utils = require("LmaoLib/Utils/Utils"),
}

---@return number
function LmaoLib.GetVersion()
    return 1.100
end

--[[ Debugging ]]

-- Unloads the entire library. Useful for debugging.
function UnloadLib()
    LmaoLib.Utils.UnloadPackages("LmaoLib")
end

-- Library loaded
printc(75, 210, 55, 255, string.format("LmaoLib Loaded (v%.3f)", LmaoLib.GetVersion()))
LmaoLib.UI.Notify.Simple("LmaoLib loaded", string.format("Version: %.3f", LmaoLib.GetVersion()))

Internal.Cleanup()
return LmaoLib
