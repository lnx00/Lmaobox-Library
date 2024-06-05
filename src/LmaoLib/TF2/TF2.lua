---@class TF2
---@field public Helpers Helpers
---@field public Prediction Prediction
---@field public PlayerResource PlayerResource
---@field public Player Player
---@field public Entity EntityUtils
---@field public Weapon Weapon
local TF2 = {
    Helpers = require("LmaoLib/TF2/Helpers"),
    Prediction = require("LmaoLib/TF2/Prediction"),
    PlayerResource = require("LmaoLib/TF2/PlayerResource"),

    Player = require("LmaoLib/TF2/Player"),
    EntityUtils = require("LmaoLib/TF2/Wrappers/Entity"),
    Weapon = require("LmaoLib/TF2/Weapon")
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
