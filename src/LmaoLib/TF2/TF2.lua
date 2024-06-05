---@class TF2
---@field public Helpers Helpers
---@field public Prediction Prediction
---@field public PlayerResource PlayerResource
---@field public Player PlayerUtils
---@field public Entity EntityUtils
---@field public Weapon WeaponUtils
local TF2 = {
    Helpers = require("LmaoLib/TF2/Helpers"),
    Prediction = require("LmaoLib/TF2/Prediction"),
    PlayerResource = require("LmaoLib/TF2/PlayerResource"),

    EntityUtils = require("LmaoLib/TF2/Entities/EntityUtils"),
    PlayerUtils = require("LmaoLib/TF2/Entities/PlayerUtils"),
    WeaponUtils = require("LmaoLib/TF2/Entities/WeaponUtils")
}

function TF2.Exit()
    os.exit()
end

-- Returns if the given player is friendly
---@param playerIndex integer
---@param inParty boolean?
---@return boolean
function TF2.IsFriend(playerIndex, inParty)
    if playerIndex == client.GetLocalPlayerIndex() then return true end

    -- Check if the target is a friend or ignored
    local playerInfo = client.GetPlayerInfo(playerIndex)
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
