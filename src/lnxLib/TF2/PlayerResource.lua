--[[
    Player Resource
]]

---@class PlayerResource
local PlayerResource = {}

--[[ DT_PlayerResource ]]

-- Returns the ping of the given player
---@return integer[]
function PlayerResource.GetPing()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iPing")
end

-- Returns the score of the given player
---@return integer[]
function PlayerResource.GetScore()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iScore")
end

-- Returns the deaths of the given player
---@return integer[]
function PlayerResource.GetDeaths()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iDeaths")
end

-- Returns if the given player is connected
---@return boolean[]
function PlayerResource.GetConnected()
    return entities.GetPlayerResources():GetPropDataTableBool("m_bConnected")
end

-- Returns the team number of the given player
---@return integer[]
function PlayerResource.GetTeam()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iTeam")
end

-- Returns if the given player is alive
---@return boolean[]
function PlayerResource.GetAlive()
    return entities.GetPlayerResources():GetPropDataTableBool("m_bAlive")
end

-- Returns the health of the given player
---@return integer[]
function PlayerResource.GetHealth()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iHealth")
end

-- Returns the account ID of the given player (SteamID 3)
---@return integer[]
function PlayerResource.GetAccountID()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iAccountID")
end

-- Returns if the given player is valid
---@return boolean[]
function PlayerResource.GetValid()
    return entities.GetPlayerResources():GetPropDataTableBool("m_bValid")
end

-- Returns the user ID of the given player
---@return integer[]
function PlayerResource.GetUserID()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iUserID")
end

--[[ DT_TFPlayerResource ]]

-- Returns the total score of the given player
---@return integer[]
function PlayerResource.GetTotalScore()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iTotalScore")
end

-- Returns the max health of the given player
---@return integer[]
function PlayerResource.GetMaxHealth()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iMaxHealth")
end

-- Returns the max buffed health of the given player
---@return integer[]
function PlayerResource.GetMaxBuffedHealth()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iMaxBuffedHealth")
end

-- Returns the class number of the given player
---@return integer[]
function PlayerResource.GetPlayerClass()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iPlayerClass")
end

---@return boolean[]
function PlayerResource.GetArenaSpectator()
    return entities.GetPlayerResources():GetPropDataTableBool("m_bArenaSpectator")
end

-- Returns the amount of active dominations of the given player
---@return integer[]
function PlayerResource.GetActiveDominations()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iActiveDominations")
end

-- Returns when the given player will respawn
---@return number[]
function PlayerResource.GetNextRespawnTime()
    return entities.GetPlayerResources():GetPropDataTableFloat("m_flNextRespawnTime")
end

---@return integer[]
function PlayerResource.GetChargeLevel()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iChargeLevel")
end

-- Returns the damage amount of the given player
---@return integer[]
function PlayerResource.GetDamage()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iDamage")
end

-- Returns the damage assist amount of the given player
---@return integer[]
function PlayerResource.GetDamageAssist()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iDamageAssist")
end

-- Returns the boss damage of the given player
---@return integer[]
function PlayerResource.GetDamageBoss()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iDamageBoss")
end

-- Returns the healing of the given player
---@return integer[]
function PlayerResource.GetHealing()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iHealing")
end

-- Returns the healing assist amount of the given player
---@return integer[]
function PlayerResource.GetHealingAssist()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iHealingAssist")
end

-- Returns the blocked damage of the given player
---@return integer[]
function PlayerResource.GetDamageBlocked()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iDamageBlocked")
end

-- Returns the amount of currency collected of the given player
---@return integer[]
function PlayerResource.GetCurrencyCollected()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iCurrencyCollected")
end

---@return integer[]
function PlayerResource.GetBonusPoints()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iBonusPoints")
end

-- Returns the level of the given player
---@return integer[]
function PlayerResource.GetPlayerLevel()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iPlayerLevel")
end

---@return integer[]
function PlayerResource.GetStreaks()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iStreaks")
end

---@return integer[]
function PlayerResource.GetUpgradeRefundCredits()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iUpgradeRefundCredits")
end

---@return integer[]
function PlayerResource.GetBuybackCredits()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iBuybackCredits")
end

---@return integer[]
function PlayerResource.GetPartyLeaderRedTeamIndex()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iPartyLeaderRedTeamIndex")
end

---@return integer[]
function PlayerResource.GetPartyLeaderBlueTeamIndex()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iPartyLeaderBlueTeamIndex")
end

---@return integer[]
function PlayerResource.GetEventTeamStatus()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iEventTeamStatus")
end

---@return integer[]
function PlayerResource.GetPlayerClassWhenKilled()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iPlayerClassWhenKilled")
end

-- Returns the connection state of the given player
---@return integer[]
function PlayerResource.GetConnectionState()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iConnectionState")
end

-- Returns the time the given player has been connected
---@return number[]
function PlayerResource.GetConnectTime()
    return entities.GetPlayerResources():GetPropDataTableFloat("m_flConnectTime")
end

return PlayerResource
