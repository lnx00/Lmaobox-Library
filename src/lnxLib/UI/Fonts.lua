---@class Fonts
---@field public Verdana Font
---@field public Segoe Font
---@field public SegoeTitle Font
local Fonts = table.readOnly {
    Verdana = draw.CreateFont("Verdana", 14, 510),
    Segoe = draw.CreateFont("Segoe UI", 14, 510),
    SegoeTitle = draw.CreateFont("Segoe UI", 24, 700)
}

return Fonts
