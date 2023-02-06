--[[
    Wrapper Class for Wepaon Entities
]]

---@type WEntity
local WEntity = require("Library/TF2/Wrappers/WEntity")

---@class WPlayerResource : WEntity
local WPlayerResource = {}
WPlayerResource.__index = WPlayerResource
setmetatable(WPlayerResource, WEntity)

--[[ Contructors ]]

-- Creates a WPlayerResource from a given native Entity
---@param entity Entity
---@return WPlayerResource
function WPlayerResource.FromEntity(entity)
    assert(entity, "WPlayerResource.FromEntity: entity is nil")

    local self = setmetatable({}, WPlayerResource)
    self:SetEntity(entity)

    return self
end

-- Returns the current player resource entity
---@return WPlayerResource|nil
function WPlayerResource.Get()
    local pr = entities.GetPlayerResources()
    return pr ~= nil and WPlayerResource.FromEntity(pr) or nil
end

--[[ Wrapper functions ]]

-- DT_PlayerResource

-- Returns the ping of the given player
---@param index number
---@return integer
function WPlayerResource:GetPing(index)
    return self:GetPropDataTableInt("m_iPing")[index + 1]
end

-- Returns the score of the given player
---@param index number
---@return integer
function WPlayerResource:GetScore(index)
    return self:GetPropDataTableInt("m_iScore")[index + 1]
end

-- Returns the deaths of the given player
---@param index number
---@return integer
function WPlayerResource:GetDeaths(index)
    return self:GetPropDataTableInt("m_iDeaths")[index + 1]
end

-- Returns if the given player is connected
---@param index number
---@return boolean
function WPlayerResource:GetConnected(index)
    return self:GetPropDataTableInt("m_bConnected")[index + 1] == 1
end

-- Returns the team number of the given player
---@param index number
---@return integer
function WPlayerResource:GetTeam(index)
    return self:GetPropDataTableInt("m_iTeam")[index + 1]
end

-- Returns if the given player is alive
---@param index number
---@return boolean
function WPlayerResource:GetAlive(index)
    return self:GetPropDataTableInt("m_bAlive")[index + 1] == 1
end

-- Returns the health of the given player
---@param index number
---@return integer
function WPlayerResource:GetHealth(index)
    return self:GetPropDataTableInt("m_iHealth")[index + 1]
end

-- Returns the account ID of the given player
---@param index number
---@return integer
function WPlayerResource:GetAccountID(index)
    return self:GetPropDataTableInt("m_iAccountID")[index + 1]
end

-- Returns if the given player is valid
---@param index number
---@return boolean
function WPlayerResource:GetValid(index)
    return self:GetPropDataTableInt("m_bValid")[index + 1] == 1
end

-- Returns the user ID of the given player
---@param index number
---@return integer
function WPlayerResource:GetUserID(index)
    return self:GetPropDataTableInt("m_iUserID")[index + 1]
end

-- DT_TFPlayerResource

-- Returns the total score of the given player
---@param index number
---@return integer
function WPlayerResource:GetTotalScore(index)
    return self:GetPropDataTableInt("m_iTotalScore")[index + 1]
end

-- Returns the max health of the given player
---@param index number
---@return integer
function WPlayerResource:GetMaxHealth(index)
    return self:GetPropDataTableInt("m_iMaxHealth")[index + 1]
end

-- Returns the max buffed health of the given player
---@param index number
---@return integer
function WPlayerResource:GetMaxBuffedHealth(index)
    return self:GetPropDataTableInt("m_iMaxBuffedHealth")[index + 1]
end

-- Returns the class number of the given player
---@param index number
---@return integer
function WPlayerResource:GetPlayerClass(index)
    return self:GetPropDataTableInt("m_iPlayerClass")[index + 1]
end

---@param index number
---@return boolean
function WPlayerResource:GetArenaSpectator(index)
    return self:GetPropDataTableInt("m_bArenaSpectator")[index + 1] == 1
end

-- Returns the amount of active dominations of the given player
---@param index number
---@return integer
function WPlayerResource:GetActiveDominations(index)
    return self:GetPropDataTableInt("m_iActiveDominations")[index + 1]
end

-- Returns when the given player will respawn
---@param index number
---@return number
function WPlayerResource:GetNextRespawnTime(index)
    return self:GetPropDataTableFloat("m_flNextRespawnTime")[index + 1]
end

---@param index number
---@return integer
function WPlayerResource:GetChargeLevel(index)
    return self:GetPropDataTableInt("m_iChargeLevel")[index + 1]
end

-- Returns the damage amount of the given player
---@param index number
---@return integer
function WPlayerResource:GetDamage(index)
    return self:GetPropDataTableInt("m_iDamage")[index + 1]
end

-- Returns the damage assist amount of the given player
---@param index number
---@return integer
function WPlayerResource:GetDamageAssist(index)
    return self:GetPropDataTableInt("m_iDamageAssist")[index + 1]
end

-- Returns the boss damage of the given player
---@param index number
---@return integer
function WPlayerResource:GetDamageBoss(index)
    return self:GetPropDataTableInt("m_iDamageBoss")[index + 1]
end

-- Returns the healing of the given player
---@param index number
---@return integer
function WPlayerResource:GetHealing(index)
    return self:GetPropDataTableInt("m_iHealing")[index + 1]
end

-- Returns the healing assist amount of the given player
---@param index number
---@return integer
function WPlayerResource:GetHealingAssist(index)
    return self:GetPropDataTableInt("m_iHealingAssist")[index + 1]
end

-- Returns the blocked damage of the given player
---@param index number
---@return integer
function WPlayerResource:GetDamageBlocked(index)
    return self:GetPropDataTableInt("m_iDamageBlocked")[index + 1]
end

-- Returns the amount of currency collected of the given player
---@param index number
---@return integer
function WPlayerResource:GetCurrencyCollected(index)
    return self:GetPropDataTableInt("m_iCurrencyCollected")[index + 1]
end

---@param index number
---@return integer
function WPlayerResource:GetBonusPoints(index)
    return self:GetPropDataTableInt("m_iBonusPoints")[index + 1]
end

-- Returns the level of the given player
---@param index number
---@return integer
function WPlayerResource:GetPlayerLevel(index)
    return self:GetPropDataTableInt("m_iPlayerLevel")[index + 1]
end

---@param index number
---@return integer
function WPlayerResource:GetStreaks(index)
    return self:GetPropDataTableInt("m_iStreaks")[index + 1]
end

---@param index number
---@return integer
function WPlayerResource:GetUpgradeRefundCredits(index)
    return self:GetPropDataTableInt("m_iUpgradeRefundCredits")[index + 1]
end

---@param index number
---@return integer
function WPlayerResource:GetBuybackCredits(index)
    return self:GetPropDataTableInt("m_iBuybackCredits")[index + 1]
end

---@param index number
---@return integer
function WPlayerResource:GetPartyLeaderRedTeamIndex(index)
    return self:GetPropDataTableInt("m_iPartyLeaderRedTeamIndex")[index + 1]
end

---@param index number
---@return integer
function WPlayerResource:GetPartyLeaderBlueTeamIndex(index)
    return self:GetPropDataTableInt("m_iPartyLeaderBlueTeamIndex")[index + 1]
end

---@param index number
---@return integer
function WPlayerResource:GetEventTeamStatus(index)
    return self:GetPropDataTableInt("m_iEventTeamStatus")[index + 1]
end

---@param index number
---@return integer
function WPlayerResource:GetPlayerClassWhenKilled(index)
    return self:GetPropDataTableInt("m_iPlayerClassWhenKilled")[index + 1]
end

-- Returns the connection state of the given player
---@param index number
---@return integer
function WPlayerResource:GetConnectionState(index)
    return self:GetPropDataTableInt("m_iConnectionState")[index + 1]
end

-- Returns the time the given player has been connected
---@param index number
---@return number
function WPlayerResource:GetConnectTime(index)
    return self:GetPropDataTableFloat("m_flConnectTime")[index + 1]
end

return WPlayerResource
