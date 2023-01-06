---@class UI
---@field public Fonts Fonts
---@field public Textures Textures
---@field public Notify Notify
local UI = {
    Fonts = require("Library/UI/Fonts"),
    Textures = require("Library/UI/Textures"),
    Notify = require("Library/UI/Notify")
}

function UI._OnDraw()
    UI.Notify._OnDraw()
end

return UI
