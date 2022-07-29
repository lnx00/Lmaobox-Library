---@class TF2
---@field public Globals Globals
---@field public EntityCache EntityCache
---@field public WPlayer WPlayer
---@field public WEntity WEntity
---@field public WWeapon WWeapon
local TF2 = {
    Helpers = require(LIB_PATH .. "TF2/Helpers"),
    Globals = require(LIB_PATH .. "TF2/Globals"),
    EntityCache = require(LIB_PATH .. "TF2/EntityCache"),

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

function TF2._OnDraw()

end

return TF2