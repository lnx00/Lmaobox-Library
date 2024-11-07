--[[
    Player Resource
]]

---@class PlayerResource
local pr = {}

--[[ DT_PlayerResource ]]

-- Returns the ping of the given player
---@return integer[]
function pr.GetPing()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iPing")
end

-- Returns the score of the given player
---@return integer[]
function pr.GetScore()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iScore")
end

-- Returns the deaths of the given player
---@return integer[]
function pr.GetDeaths()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iDeaths")
end

-- Returns if the given player is connected
---@return boolean[]
function pr.GetConnected()
    return entities.GetPlayerResources():GetPropDataTableBool("m_bConnected")
end

-- Returns the team number of the given player
---@return integer[]
function pr.GetTeam()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iTeam")
end

-- Returns if the given player is alive
---@return boolean[]
function pr.GetAlive()
    return entities.GetPlayerResources():GetPropDataTableBool("m_bAlive")
end

-- Returns the health of the given player
---@return integer[]
function pr.GetHealth()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iHealth")
end

-- Returns the account ID of the given player (SteamID 3)
---@return integer[]
function pr.GetAccountID()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iAccountID")
end

-- Returns if the given player is valid
---@return boolean[]
function pr.GetValid()
    return entities.GetPlayerResources():GetPropDataTableBool("m_bValid")
end

-- Returns the user ID of the given player
---@return integer[]
function pr.GetUserID()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iUserID")
end

--[[ DT_TFPlayerResource ]]

-- Returns the total score of the given player
---@return integer[]
function pr.GetTotalScore()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iTotalScore")
end

-- Returns the max health of the given player
---@return integer[]
function pr.GetMaxHealth()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iMaxHealth")
end

-- Returns the max buffed health of the given player
---@return integer[]
function pr.GetMaxBuffedHealth()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iMaxBuffedHealth")
end

-- Returns the class number of the given player
---@return integer[]
function pr.GetPlayerClass()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iPlayerClass")
end

---@return boolean[]
function pr.GetArenaSpectator()
    return entities.GetPlayerResources():GetPropDataTableBool("m_bArenaSpectator")
end

-- Returns the amount of active dominations of the given player
---@return integer[]
function pr.GetActiveDominations()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iActiveDominations")
end

-- Returns when the given player will respawn
---@return number[]
function pr.GetNextRespawnTime()
    return entities.GetPlayerResources():GetPropDataTableFloat("m_flNextRespawnTime")
end

---@return integer[]
function pr.GetChargeLevel()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iChargeLevel")
end

-- Returns the damage amount of the given player
---@return integer[]
function pr.GetDamage()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iDamage")
end

-- Returns the damage assist amount of the given player
---@return integer[]
function pr.GetDamageAssist()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iDamageAssist")
end

-- Returns the boss damage of the given player
---@return integer[]
function pr.GetDamageBoss()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iDamageBoss")
end

-- Returns the healing of the given player
---@return integer[]
function pr.GetHealing()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iHealing")
end

-- Returns the healing assist amount of the given player
---@return integer[]
function pr.GetHealingAssist()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iHealingAssist")
end

-- Returns the blocked damage of the given player
---@return integer[]
function pr.GetDamageBlocked()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iDamageBlocked")
end

-- Returns the amount of currency collected of the given player
---@return integer[]
function pr.GetCurrencyCollected()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iCurrencyCollected")
end

---@return integer[]
function pr.GetBonusPoints()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iBonusPoints")
end

-- Returns the level of the given player
---@return integer[]
function pr.GetPlayerLevel()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iPlayerLevel")
end

---@return integer[]
function pr.GetStreaks()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iStreaks")
end

---@return integer[]
function pr.GetUpgradeRefundCredits()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iUpgradeRefundCredits")
end

---@return integer[]
function pr.GetBuybackCredits()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iBuybackCredits")
end

---@return integer[]
function pr.GetPartyLeaderRedTeamIndex()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iPartyLeaderRedTeamIndex")
end

---@return integer[]
function pr.GetPartyLeaderBlueTeamIndex()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iPartyLeaderBlueTeamIndex")
end

---@return integer[]
function pr.GetEventTeamStatus()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iEventTeamStatus")
end

---@return integer[]
function pr.GetPlayerClassWhenKilled()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iPlayerClassWhenKilled")
end

-- Returns the connection state of the given player
---@return integer[]
function pr.GetConnectionState()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iConnectionState")
end

-- Returns the time the given player has been connected
---@return number[]
function pr.GetConnectTime()
    return entities.GetPlayerResources():GetPropDataTableFloat("m_flConnectTime")
end

return pr
