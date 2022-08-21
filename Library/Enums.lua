--[[
    Enums
]]

---@class Enums
local Enums = { }

Enums.HexColor = {
    Red = 0xFF0000,
    Green = 0x00FF00,
    Blue = 0x0000FF,
    Yellow = 0xFFFF00,
    Cyan = 0x00FFFF,
    Magenta = 0xFF00FF,
    White = 0xFFFFFF,
    Black = 0x000000,
    Orange = 0xFFA500,
    Brown = 0xA52A2A,
    Gray = 0x808080,
}

-- Chat Colors for ChatPrintf
Enums.ChatColor = {
    White = "\x01",
    Old = "\x02",
    Player = "\x03",
    Location = "\x04",
    Achievement = "\x05",
    Black = "\x06",
    Custom = "\x07",
    Alpha = "\x08",
    Red = "\x07FF0000",
    Green = "\x0700FF00",
    Blue = "\x070000FF",
    Yellow = "\x07FFFF00",
    Cyan = "\x0700FFFF",
    Magenta = "\x07FF00FF",
    Orange = "\x07FFA500",
    Brown = "\x07A52A2A",
    Gray = "\x07808080",
}

return Enums