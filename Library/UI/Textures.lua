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

---@param data table
---@return string
local function TableToBinary(data)
    return table.concat(data)
end

-- [PERFORMANCE INTENSIVE] Creates a linear gradient (255 pixels or greater)
---@param startColor table<number, number, number, number>
---@param endColor table<number, number, number, number>
---@param size table<number, number>
---@return string
function Textures.LinearGradient(startColor, endColor, size)
    local sR, sG, sB, sA = table.unpack(startColor)
    local eR, eG, eB, eA = table.unpack(endColor)
    sA, eA = sA or 255, eA or 255
    local width = size[1] or 255
    local height = size[2] or 255

    local data = {}
    for y = 1, height do
        local yh = y / height
        for x = 1, width do
            local xw = x / width
            table.insert(data, byteMap[math.floor(sR + (eR - sR) * xw)])
            table.insert(data, byteMap[math.floor(sG + (eG - sG) * yh)])
            table.insert(data, byteMap[math.floor(sB + (eB - sB) * xw)])
            table.insert(data, byteMap[math.floor(sA + (eA - sA) * yh)])
        end
    end

    return TableToBinary(data)
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
