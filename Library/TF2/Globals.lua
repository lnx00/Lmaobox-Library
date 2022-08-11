--[[
    Global variables for TF2
]]

---@class Globals
---@field public LastCommandNumber number
---@field public CommandNumber number
local Globals = {
    LastCommandNumber = 0,
    CommandNumber = 0,

    DefaultFont = draw.CreateFont("Verdana", 14, 510),
    TitleFont = draw.CreateFont("Verdana", 24, 700),
}

-- Updates the global variables
---@param userCmd UserCmd
function Globals._OnCreateMove(userCmd)
    Globals.LastCommandNumber = Globals.CommandNumber
    Globals.CommandNumber = userCmd.command_number
end

return Globals