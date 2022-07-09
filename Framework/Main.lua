--[[ Globals ]]

-- Get the current folder for relative require
LNXF_PATH = debug.getinfo(1, "S").source:sub(2):match("(.*/)")

--[[ Main ]]
local Main = {
    Utils = require(LNXF_PATH .. "Utils/Utils"),
}

return Main