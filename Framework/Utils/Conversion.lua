local Conversion = { }

-- Converts a given SteamID 3 to SteamID 64
function Conversion.ID3_to_ID64(steamID3)
    local id = string.sub(steamID3, 6, #steamID3 - 1)
    return tonumber(id) + 0x110000100000000
end

-- Converts a given SteamID 64 to a SteamID 3
function Conversion.ID64_to_ID3(pID64)
    return "[U:1:" .. (tonumber(pID64) ^ 0x110000100000000) .. "]"
end

-- Converts a given Hex Color to RGB
function Conversion.Hex_to_RGB(pHex)
    local r = tonumber(string.sub(pHex, 1, 2), 16)
    local g = tonumber(string.sub(pHex, 3, 4), 16)
    local b = tonumber(string.sub(pHex, 5, 6), 16)
    return { r, g, b }
end

-- Converts a given RGB Color to Hex
function Conversion.RGB_to_Hex(pRGB)
    local r = string.format("%x", pRGB[1])
    local g = string.format("%x", pRGB[2])
    local b = string.format("%x", pRGB[3])
    return r .. g .. b
end

return Conversion