---@class UI
---@field public Fonts Fonts
---@field public Draw3D Draw3D
---@field public Textures Textures
---@field public Notify Notify
local UI = {
    Fonts = require("LmaoLib/UI/Fonts"),
    Draw3D = require("LmaoLib/UI/Draw3D"),
    Textures = require("LmaoLib/UI/Textures"),
    Notify = require("LmaoLib/UI/Notify")
}

return UI
