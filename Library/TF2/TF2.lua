---@class TF2
---@field public Globals Globals
local TF2 = {
    Helpers = require(LIB_PATH .. "TF2/Helpers"),
    Globals = require(LIB_PATH .. "TF2/Globals"),

    WPlayer = require(LIB_PATH .. "TF2/Wrappers/WPlayer"),
    WEntity = require(LIB_PATH .. "TF2/Wrappers/WEntity"),
    WWeapon = require(LIB_PATH .. "TF2/Wrappers/WWeapon"),
}

function TF2.Exit()
    os.exit()
end

function TF2._OnCreateMove(userCmd)
    TF2.Globals._OnCreateMove(userCmd)
end

return TF2