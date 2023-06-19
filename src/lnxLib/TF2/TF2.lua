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

-- Returns if the given player is friendly
---@param idx integer
---@param inParty boolean?
---@return boolean
function TF2.IsFriend(idx, inParty)
    if idx == client.GetLocalPlayerIndex() then return true end

    -- Check if the target is a friend or ignored
    local playerInfo = client.GetPlayerInfo(idx)
    if steam.IsFriend(playerInfo.SteamID) then return true end
    if playerlist.GetPriority(playerInfo.UserID) < 0 then return true end

    -- Check if the target is a party member
    if inParty then
        local partyMembers = party.GetMembers()
        if partyMembers then
            for _, member in ipairs(partyMembers) do
                if member == playerInfo.SteamID then return true end
            end
        end
    end

    return false
end

return TF2
