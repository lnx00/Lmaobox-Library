-- Globals
require("src/Global/Global")

--[[ Main ]]

---A utility library for Lmaobox
---@class LmaoLib
---@field public TF2 TF2
---@field public UI UI
---@field public Utils Utils
local LmaoLib = {
    TF2 = require("src/TF2/TF2"),
    UI = require("src/UI/UI"),
    Utils = require("src/Utils/Utils"),
}

---@return number
function LmaoLib.GetVersion()
    return 1.100
end

--[[ Debugging ]]

-- Unloads the entire library. Useful for debugging.
function _DEBUG_UNLOAD_LMAOLIB()
    LmaoLib.Utils.UnloadPackages("LmaoLib")
end

-- Library loaded
printc(75, 210, 55, 255, string.format("LmaoLib loaded (v%.3f)", LmaoLib.GetVersion()))
LmaoLib.UI.Notify.Simple("LmaoLib loaded", string.format("Version: %.3f", LmaoLib.GetVersion()))

Internal.Cleanup()
return LmaoLib
