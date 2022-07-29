--[[
    Global variables for TF2
]]

---@class Globals
---@field public LastUserCmd UserCmd
---@field public CurrentUserCmd UserCmd
local Globals = {
    ---@type UserCmd
    LastUserCmd = nil,

    ---@type UserCmd
    CurrentUserCmd = nil,
}

function Globals._OnCreateMove(userCmd)
    Globals.LastUserCmd = Globals.CurrentUserCmd
    Globals.CurrentUserCmd = userCmd
end

return Globals