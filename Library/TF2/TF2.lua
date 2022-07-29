local TF2 = {
    Helpers = require(LIB_PATH .. "TF2/Helpers"),

    WPlayer = require(LIB_PATH .. "TF2/Wrappers/WPlayer"),
    WEntity = require(LIB_PATH .. "TF2/Wrappers/WEntity"),
    WWeapon = require(LIB_PATH .. "TF2/Wrappers/WWeapon"),
}

function TF2.Exit()
    os.exit()
end

return TF2