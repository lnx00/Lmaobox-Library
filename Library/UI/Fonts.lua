---@class Fonts
---@field public Verdana number
---@field public Segoe number
---@field public SegoeTitle number
local Fonts = {
    Verdana = draw.CreateFont("Verdana", 14, 510),
    Segoe = draw.CreateFont("Segoe UI", 14, 510),
    SegoeTitle = draw.CreateFont("Segoe UI", 24, 700),
}

return Fonts