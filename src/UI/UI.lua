---@class UI
---@field public Fonts Fonts
---@field public Draw3D Draw3D
---@field public Textures Textures
---@field public Notify Notify
local UI = {
    Fonts = require("src/UI/Fonts"),
    Draw3D = require("src/UI/Draw3D"),
    Textures = require("src/UI/Textures"),
    Notify = require("src/UI/Notify")
}

return UI
