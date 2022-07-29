--[[ Globals ]]

-- Get the current folder for relative require
LIB_PATH = debug.getinfo(1, "S").source:sub(2):match("(.*/)")

--[[ Main ]]
local Main = {
    TF2 = require(LIB_PATH .. "TF2/TF2"),
    UI = require(LIB_PATH .. "UI/UI"),
    Utils = require(LIB_PATH .. "Utils/Utils"),
}

function Main:GetVersion()
    return 0.1
end

return Main