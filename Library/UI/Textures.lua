--[[
    Creates gradients in the RGBA8888 format as RGBA binary data.
    Can be used to draw textures in the UI.
]]
---@class Textures
local Textures = {}

local byteMap = {}
for i = 0, 255 do
    byteMap[i] = string.char(i)
end

local function GetColor(color)
    local r, g, b, a = table.unpack(color)
    a = a or 255
    return r, g, b, a
end

local function GetSize(size)
    local w, h = table.unpack(size)
    w, h = w or 255, h or 255
    return w, h
end

-- [PERFORMANCE INTENSIVE] Creates a linear gradient
---@param startColor table<number, number, number, number>
---@param endColor table<number, number, number, number>
---@param size table<number, number>
---@return string
function Textures.LinearGradient(startColor, endColor, size)
    local sR, sG, sB, sA = GetColor(startColor)
    local eR, eG, eB, eA = GetColor(endColor)
    local w, h = GetSize(size)

    local dataSize = w * h * 4
    local data = {}
    local bm = byteMap
    
    local i = 1
    while i < dataSize do
        local idx = (i / 4)
        local x, y = idx % w, idx // w

        data[i] = bm[sR + (eR - sR) * x // w]
        data[i + 1] = bm[sG + (eG - sG) * y // h]
        data[i + 2] = bm[sB + (eB - sB) * x // w]
        data[i + 3] = bm[sA + (eA - sA) * y // h]

        i = i + 4
    end

    return table.concat(data)
end

-- [PERFORMANCE INTENSIVE] Creates a circle with a given color
---@param radius number
---@param color table<number, number, number, number>
function Textures.Circle(radius, color)
    color[4] = color[4] or 255

    local data = ""
    local step = {}
    local stepX = 0
    local stepY = 0
    local stepZ = 0
    local stepW = 0
    for i = 0, radius do
        stepX = math.cos(i * math.pi / radius)
        stepY = math.sin(i * math.pi / radius)
        for j = 0, radius do
            stepZ = math.cos(j * math.pi / radius)
            stepW = math.sin(j * math.pi / radius)
            step[1] = math.floor(color[1] * stepX)
            step[2] = math.floor(color[2] * stepY)
            step[3] = math.floor(color[3] * stepZ)
            step[4] = math.floor(color[4] * stepW)

            data = data .. string.char(step[1]) .. string.char(step[2]) .. string.char(step[3]) .. string.char(step[4])
        end
    end

    return data
end

return Textures
