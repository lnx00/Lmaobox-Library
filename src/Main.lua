-- Globals
require("src/Global/Global")

--[[ Main ]]

---A utility library for Lmaobox
---@class LmaoLib
---@field public tf2 TF2
---@field public ui UI
---@field public utils Utils
local lib = {
    tf2 = require("src/TF2/TF2"),
    ui = require("src/UI/UI"),
    utils = require("src/Utils/Utils"),
}

---@return number
function lib.version()
    return 1.101
end

--[[ Debugging ]]

-- Unloads the entire library. Useful for debugging.
_G["_DEBUG_UNLOAD_LMAOLIB"] = function ()
    lib.utils.UnloadPackages("LmaoLib")
end

-- Library loaded
printc(75, 210, 55, 255, string.format("LmaoLib loaded (v%.3f)", lib.version()))

Internal.Cleanup()
return lib
