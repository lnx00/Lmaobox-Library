---@class UI
---@field public Fonts Fonts
---@field public Draw3D Draw3D
---@field public Textures Textures
---@field public Notify Notify
local UI = {
    Fonts = require("lnxLib/UI/Fonts"),
    Draw3D = require("lnxLib/UI/Draw3D"),
    Textures = require("lnxLib/UI/Textures"),
    Notify = require("lnxLib/UI/Notify")
}

return UI
