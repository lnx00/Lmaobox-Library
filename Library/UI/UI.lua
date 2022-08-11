---@class UI
---@field public Textures Textures
---@field public Notify Notify
local UI = {
    Textures = require(LIB_PATH .. "UI/Textures"),
    Notify = require(LIB_PATH .. "UI/Notify")
}

function UI._OnDraw()
    UI.Notify._OnDraw()
end

return UI