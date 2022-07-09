--[[ Globals ]]

-- Get the current folder for relative require
LNXF_PATH = debug.getinfo(1, "S").source:sub(2):match("(.*/)")

--[[ Main ]]
local Main = {
    TF2 = require(LNXF_PATH .. "TF2/TF2"),
    Utils = require(LNXF_PATH .. "Utils/Utils"),
}

return Main