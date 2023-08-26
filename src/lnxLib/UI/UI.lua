---@class UI
---@field public Fonts Fonts
---@field public Draw Draw
---@field public Textures Textures
---@field public Notify Notify
local UI = {
    Fonts = require("lnxLib/UI/Fonts"),
    Draw = require("lnxLib/UI/Draw"),
    Textures = require("lnxLib/UI/Textures"),
    Notify = require("lnxLib/UI/Notify")
}

return UI
