---@class TF2
---@field public Helpers Helpers
---@field public Prediction Prediction
---@field public WPlayer WPlayer
---@field public WEntity WEntity
---@field public WWeapon WWeapon
---@field public WPlayerResource WPlayerResource
local TF2 = {
    Helpers = require("lnxLib/TF2/Helpers"),
    Prediction = require("lnxLib/TF2/Prediction"),

    WPlayer = require("lnxLib/TF2/Wrappers/WPlayer"),
    WEntity = require("lnxLib/TF2/Wrappers/WEntity"),
    WWeapon = require("lnxLib/TF2/Wrappers/WWeapon"),
    WPlayerResource = require("lnxLib/TF2/Wrappers/WPlayerResource")
}

function TF2.Exit()
    os.exit()
end

return TF2
