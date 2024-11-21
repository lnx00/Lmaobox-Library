---@class TF2
---@field public helpers Helpers
---@field public pred Prediction
---@field public pr PlayerResource
---@field public Player PlayerUtils
---@field public Entity EntityUtils
---@field public Weapon WeaponUtils
local tf2 = {
    helpers = require("src/TF2/Helpers"),
    pred = require("src/TF2/Prediction"),
    pr = require("src/TF2/PlayerResource"),

    entityutil = require("src/TF2/Entities/EntityUtils"),
    playerutil = require("src/TF2/Entities/PlayerUtils"),
    weaponutil = require("src/TF2/Entities/WeaponUtils")
}

function tf2.exit()
    os.exit()
end

-- Returns if the given player is friendly
---@param playerIndex integer
---@param inParty boolean?
---@return boolean
function tf2.is_friend(playerIndex, inParty)
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

return tf2
