--[[
    Entity List
]]

---@type Globals
local Globals = require(LIB_PATH .. "TF2/Globals")

---@type Entity[]
local LastPlayerList = {}

---@type Entity[]
local LastTeamList = {}

---@type Entity[]
local LastEnemyList = {}

local function UpdateCache()
    if Globals.CommandNumber == Globals.LastCommandNumber then
        return
    end

    LastPlayerList = entities.FindByClass("CTFPlayer")
    local localPlayer = entities.GetLocalPlayer()
    table.remove(LastPlayerList, localPlayer:GetIndex())

    -- Iterate through all players of LastPlayerList
    for _, player in pairs(LastPlayerList) do
        if player:GetTeamNumber() == localPlayer:GetTeamNumber() then
            table.insert(LastTeamList, player)
        else
            table.insert(LastEnemyList, player)
        end
    end
end

---@class EntityCache
local EntityCache = { }

---@return Entity[]
function EntityCache.GetPlayers()
    UpdateCache()
    return LastPlayerList
end

---@return Entity[]
function EntityCache.GetTeam()
    UpdateCache()
    return LastTeamList
end

---@return Entity[]
function EntityCache.GetEnemies()
    UpdateCache()
    return LastEnemyList
end

return EntityCache