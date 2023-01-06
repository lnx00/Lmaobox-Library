---@class TF2
---@field public Globals Globals
---@field public WPlayer WPlayer
---@field public WEntity WEntity
---@field public WWeapon WWeapon
---@field public WPlayerResource WPlayerResource
local TF2 = {
    Helpers = require("Library/TF2/Helpers"),
    Globals = require("Library/TF2/Globals"),

    WPlayer = require("Library/TF2/Wrappers/WPlayer"),
    WEntity = require("Library/TF2/Wrappers/WEntity"),
    WWeapon = require("Library/TF2/Wrappers/WWeapon"),
    WPlayerResource = require("Library/TF2/Wrappers/WPlayerResource")
}

function TF2.Exit()
    os.exit()
end

function TF2._OnCreateMove(userCmd)
    TF2.Globals._OnCreateMove(userCmd)
end

return TF2
