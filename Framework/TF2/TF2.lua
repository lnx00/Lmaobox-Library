local TF2 = {
    Helpers = require(LNXF_PATH .. "TF2/Helpers"),

    WPlayer = require(LNXF_PATH .. "TF2/Wrappers/WPlayer"),
    WEntity = require(LNXF_PATH .. "TF2/Wrappers/WEntity"),
    WWeapon = require(LNXF_PATH .. "TF2/Wrappers/WWeapon"),
}

function TF2.Exit()
    os.exit()
end

return TF2