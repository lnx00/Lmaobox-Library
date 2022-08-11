---@class UI
---@field public Fonts Fonts
---@field public Textures Textures
---@field public Notify Notify
local UI = {
    Fonts = require(LIB_PATH .. "UI/Fonts"),
    Textures = require(LIB_PATH .. "UI/Textures"),
    Notify = require(LIB_PATH .. "UI/Notify")
}

function UI._OnDraw()
    UI.Notify._OnDraw()
end

return UI