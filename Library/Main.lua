--[[
    LNXlib - A utility library for Lmaobox
]]

-- Globals
require("Library/Global/Global")

--[[ Main ]]

---@class LNXlib
---@field public TF2 TF2
---@field public UI UI
---@field public Utils Utils
local LNXlib = {
    TF2 = require("Library/TF2/TF2"),
    UI = require("Library/UI/UI"),
    Utils = require("Library/Utils/Utils"),
}

---@return number
function LNXlib.GetVersion()
    return 0.962
end

--[[ Debugging ]]

-- Unloads the entire library. Useful for debugging
function UnloadLib()
    LNXlib.Utils.UnloadPackages("LNXlib")
end

-- Library loaded
printc(75, 210, 55, 255, string.format("LNXlib Loaded (v%.3f)", LNXlib.GetVersion()))
LNXlib.UI.Notify.Simple("LNXlib loaded", string.format("Version: %.3f", LNXlib.GetVersion()))

Internal.Cleanup()
return LNXlib
