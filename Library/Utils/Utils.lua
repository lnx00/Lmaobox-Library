---@class Utils
---@field public Conversion Conversion
---@field public IO IO
---@field public Misc Misc
---@field public Net Net
---@field public KeyHelper KeyHelper
---@field public Timer Timer
---@field public Config Config
local Utils = {
    Conversion = require("Library/Utils/Conversion"),
    IO = require("Library/Utils/IO"),
    Misc = require("Library/Utils/Misc"),
    Net = require("Library/Utils/Net"),
    KeyHelper = require("Library/Utils/KeyHelper"),
    Timer = require("Library/Utils/Timer"),
    Config = require("Library/Utils/Config"),
}

return Utils