--[[
    Wrapper Class for Wepaon Entities
]]

local WEntity = require("Library/TF2/Wrappers/WEntity")

---@class WPlayerResource : WEntity
local WPlayerResource = { }
WPlayerResource.__index = WPlayerResource
setmetatable(WPlayerResource, WEntity)

--[[ Contructors ]]

-- Creates a WPlayerResource from a given native Entity
---@param entity Entity
---@return WPlayerResource
function WPlayerResource.FromEntity(entity)
    ---@type self
    local self = setmetatable({ }, WPlayerResource)
    self.Entity = entity

    return self
end

-- Returns the current player resource entity
---@return WPlayerResource
function WPlayerResource.Get()
    return WPlayerResource.FromEntity(entities.GetPlayerResources())
end

--[[ Wrapper functions ]]

-- DT_PlayerResource

---@param index number
function WPlayerResource:GetPing(index)
    return self:GetPropDataTableInt("m_iPing")[index + 1]
end

---@param index number
function WPlayerResource:GetScore(index)
    return self:GetPropDataTableInt("m_iScore")[index + 1]
end

---@param index number
function WPlayerResource:GetDeaths(index)
    return self:GetPropDataTableInt("m_iDeaths")[index + 1]
end

---@param index number
function WPlayerResource:GetConnected(index)
    return self:GetPropDataTableInt("m_bConnected")[index + 1] == 1
end

---@param index number
function WPlayerResource:GetTeam(index)
    return self:GetPropDataTableInt("m_iTeam")[index + 1]
end

---@param index number
function WPlayerResource:GetAlive(index)
    return self:GetPropDataTableInt("m_bAlive")[index + 1] == 1
end

---@param index number
function WPlayerResource:GetHealth(index)
    return self:GetPropDataTableInt("m_iHealth")[index + 1]
end

---@param index number
function WPlayerResource:GetAccountID(index)
    return self:GetPropDataTableInt("m_iAccountID")[index + 1]
end

---@param index number
function WPlayerResource:GetValid(index)
    return self:GetPropDataTableInt("m_bValid")[index + 1] == 1
end

---@param index number
function WPlayerResource:GetUserID(index)
    return self:GetPropDataTableInt("m_iUserID")[index + 1]
end

-- DT_TFPlayerResource

---@param index number
function WPlayerResource:GetTotalScore(index)
    return self:GetPropDataTableInt("m_iTotalScore")[index + 1]
end

---@param index number
function WPlayerResource:GetMaxHealth(index)
    return self:GetPropDataTableInt("m_iMaxHealth")[index + 1]
end

---@param index number
function WPlayerResource:GetMaxBuffedHealth(index)
    return self:GetPropDataTableInt("m_iMaxBuffedHealth")[index + 1]
end

---@param index number
function WPlayerResource:GetPlayerClass(index)
    return self:GetPropDataTableInt("m_iPlayerClass")[index + 1]
end

---@param index number
function WPlayerResource:GetArenaSpectator(index)
    return self:GetPropDataTableInt("m_bArenaSpectator")[index + 1] == 1
end

---@param index number
function WPlayerResource:GetActiveDominations(index)
    return self:GetPropDataTableInt("m_iActiveDominations")[index + 1]
end

---@param index number
function WPlayerResource:GetNextRespawnTime(index)
    return self:GetPropDataTableFloat("m_flNextRespawnTime")[index + 1]
end

---@param index number
function WPlayerResource:GetChargeLevel(index)
    return self:GetPropDataTableInt("m_iChargeLevel")[index + 1]
end

---@param index number
function WPlayerResource:GetDamage(index)
    return self:GetPropDataTableInt("m_iDamage")[index + 1]
end

---@param index number
function WPlayerResource:GetDamageAssist(index)
    return self:GetPropDataTableInt("m_iDamageAssist")[index + 1]
end

---@param index number
function WPlayerResource:GetDamageBoss(index)
    return self:GetPropDataTableInt("m_iDamageBoss")[index + 1]
end

---@param index number
function WPlayerResource:GetHealing(index)
    return self:GetPropDataTableInt("m_iHealing")[index + 1]
end

---@param index number
function WPlayerResource:GetHealingAssist(index)
    return self:GetPropDataTableInt("m_iHealingAssist")[index + 1]
end

---@param index number
function WPlayerResource:GetDamageBlocked(index)
    return self:GetPropDataTableInt("m_iDamageBlocked")[index + 1]
end

---@param index number
function WPlayerResource:GetCurrencyCollected(index)
    return self:GetPropDataTableInt("m_iCurrencyCollected")[index + 1]
end

---@param index number
function WPlayerResource:GetBonusPoints(index)
    return self:GetPropDataTableInt("m_iBonusPoints")[index + 1]
end

---@param index number
function WPlayerResource:GetPlayerLevel(index)
    return self:GetPropDataTableInt("m_iPlayerLevel")[index + 1]
end

---@param index number
function WPlayerResource:GetStreaks(index)
    return self:GetPropDataTableInt("m_iStreaks")[index + 1]
end

---@param index number
function WPlayerResource:GetUpgradeRefundCredits(index)
    return self:GetPropDataTableInt("m_iUpgradeRefundCredits")[index + 1]
end

---@param index number
function WPlayerResource:GetBuybackCredits(index)
    return self:GetPropDataTableInt("m_iBuybackCredits")[index + 1]
end

---@param index number
function WPlayerResource:GetPartyLeaderRedTeamIndex(index)
    return self:GetPropDataTableInt("m_iPartyLeaderRedTeamIndex")[index + 1]
end

---@param index number
function WPlayerResource:GetPartyLeaderBlueTeamIndex(index)
    return self:GetPropDataTableInt("m_iPartyLeaderBlueTeamIndex")[index + 1]
end

---@param index number
function WPlayerResource:GetEventTeamStatus(index)
    return self:GetPropDataTableInt("m_iEventTeamStatus")[index + 1]
end

---@param index number
function WPlayerResource:GetPlayerClassWhenKilled(index)
    return self:GetPropDataTableInt("m_iPlayerClassWhenKilled")[index + 1]
end

---@param index number
function WPlayerResource:GetConnectionState(index)
    return self:GetPropDataTableInt("m_iConnectionState")[index + 1]
end

---@param index number
function WPlayerResource:GetConnectTime(index)
    return self:GetPropDataTableFloat("m_flConnectTime")[index + 1]
end

return WPlayerResource