---@class UI
---@field public fonts Fonts
---@field public draw3d Draw3D
---@field public textures Textures
---@field public notify Notify
local ui = {
    fonts = require("src/UI/Fonts"),
    draw3d = require("src/UI/Draw3D"),
    textures = require("src/UI/Textures"),
    notify = require("src/UI/Notify")
}

return ui
