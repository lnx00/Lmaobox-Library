--[[
    Global variables for TF2
]]

---@class Globals
---@field public LastCommandNumber integer
---@field public CommandNumber integer
local Globals = {
    LastCommandNumber = 0,
    CommandNumber = 0
}

-- Updates the global variables
---@param userCmd UserCmd
local function OnCreateMove(userCmd)
    Globals.LastCommandNumber = Globals.CommandNumber
    Globals.CommandNumber = userCmd.command_number
end

Internal.RegisterCallback("CreateMove", OnCreateMove, "TF2", "Globals")

return Globals
