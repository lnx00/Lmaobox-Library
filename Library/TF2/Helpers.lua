--[[
    Helpers
]]

local Helpers = { }

---@param userCmd UserCmd
---@param a Vector3
---@param b Vector3
---@return Vector3
function Helpers.ComputeMove(userCmd, a, b)
    local diff = (b - a)
    if diff:Length() == 0 then return Vector3(0, 0, 0) end

    local x = diff.x
    local y = diff.y
    local vSilent = Vector3(x, y, 0)

    local ang = vSilent:Angles()
    local cPitch, cYaw, cRoll = userCmd:GetViewAngles()
    local yaw = math.rad(ang.y - cYaw)
    local pitch = math.rad(ang.x - cPitch)
    local move = Vector3(math.cos(yaw) * 450, -math.sin(yaw) * 450, -math.cos(pitch) * 450)

    return move
end

---@param userCmd UserCmd
---@param localPlayer Entity
---@param destination Vector3
function Helpers.WalkTo(userCmd, localPlayer, destination)
    local localPos = localPlayer:GetAbsOrigin()
    local result = Helpers.ComputeMove(userCmd, localPos, destination)

    pCmd:SetForwardMove(result.x)
    pCmd:SetSideMove(result.y)
end

return Helpers