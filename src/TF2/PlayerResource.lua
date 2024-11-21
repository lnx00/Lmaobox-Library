--[[
    Player Resource
]]

---@class PlayerResource
local pr = {}

--[[ DT_PlayerResource ]]

-- Returns the ping of the given player
---@return integer[]
function pr.ping()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iPing")
end

-- Returns the score of the given player
---@return integer[]
function pr.score()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iScore")
end

-- Returns the deaths of the given player
---@return integer[]
function pr.deaths()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iDeaths")
end

-- Returns if the given player is connected
---@return boolean[]
function pr.connected()
    return entities.GetPlayerResources():GetPropDataTableBool("m_bConnected")
end

-- Returns the team number of the given player
---@return integer[]
function pr.team()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iTeam")
end

-- Returns if the given player is alive
---@return boolean[]
function pr.alive()
    return entities.GetPlayerResources():GetPropDataTableBool("m_bAlive")
end

-- Returns the health of the given player
---@return integer[]
function pr.health()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iHealth")
end

-- Returns the account ID of the given player (SteamID 3)
---@return integer[]
function pr.account_id()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iAccountID")
end

-- Returns if the given player is valid
---@return boolean[]
function pr.valid()
    return entities.GetPlayerResources():GetPropDataTableBool("m_bValid")
end

-- Returns the user ID of the given player
---@return integer[]
function pr.user_id()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iUserID")
end

--[[ DT_TFPlayerResource ]]

-- Returns the total score of the given player
---@return integer[]
function pr.total_score()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iTotalScore")
end

-- Returns the max health of the given player
---@return integer[]
function pr.max_health()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iMaxHealth")
end

-- Returns the max buffed health of the given player
---@return integer[]
function pr.max_buffed_health()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iMaxBuffedHealth")
end

-- Returns the class number of the given player
---@return integer[]
function pr.player_class()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iPlayerClass")
end

---@return boolean[]
function pr.arena_spectator()
    return entities.GetPlayerResources():GetPropDataTableBool("m_bArenaSpectator")
end

-- Returns the amount of active dominations of the given player
---@return integer[]
function pr.active_dominations()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iActiveDominations")
end

-- Returns when the given player will respawn
---@return number[]
function pr.next_respawn_time()
    return entities.GetPlayerResources():GetPropDataTableFloat("m_flNextRespawnTime")
end

---@return integer[]
function pr.charge_level()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iChargeLevel")
end

-- Returns the damage amount of the given player
---@return integer[]
function pr.damage()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iDamage")
end

-- Returns the damage assist amount of the given player
---@return integer[]
function pr.damage_assist()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iDamageAssist")
end

-- Returns the boss damage of the given player
---@return integer[]
function pr.damage_boss()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iDamageBoss")
end

-- Returns the healing of the given player
---@return integer[]
function pr.healing()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iHealing")
end

-- Returns the healing assist amount of the given player
---@return integer[]
function pr.healing_assist()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iHealingAssist")
end

-- Returns the blocked damage of the given player
---@return integer[]
function pr.damage_blocked()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iDamageBlocked")
end

-- Returns the amount of currency collected of the given player
---@return integer[]
function pr.currency_collected()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iCurrencyCollected")
end

---@return integer[]
function pr.bonus_points()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iBonusPoints")
end

-- Returns the level of the given player
---@return integer[]
function pr.player_level()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iPlayerLevel")
end

---@return integer[]
function pr.streaks()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iStreaks")
end

---@return integer[]
function pr.ipgrade_refund_credits()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iUpgradeRefundCredits")
end

---@return integer[]
function pr.buyback_credits()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iBuybackCredits")
end

---@return integer[]
function pr.party_leader_red_team_index()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iPartyLeaderRedTeamIndex")
end

---@return integer[]
function pr.party_leader_blue_team_index()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iPartyLeaderBlueTeamIndex")
end

---@return integer[]
function pr.event_team_status()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iEventTeamStatus")
end

---@return integer[]
function pr.player_class_when_killed()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iPlayerClassWhenKilled")
end

-- Returns the connection state of the given player
---@return integer[]
function pr.connection_state()
    return entities.GetPlayerResources():GetPropDataTableInt("m_iConnectionState")
end

-- Returns the time the given player has been connected
---@return number[]
function pr.connect_time()
    return entities.GetPlayerResources():GetPropDataTableFloat("m_flConnectTime")
end

return pr
