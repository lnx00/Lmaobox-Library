---@class Textures
local Textures = {}

--[[
    Creates gradients in the RGBA8888 format as RGBA binary data.
    Can be used to draw textures in lmaobox
]]

-- [PERFORMANCE INTENSIVE] Creates a linear gradient (255 pixels or greater)
---@param startColor table<number, number, number, number>
---@param endColor table<number, number, number, number>
---@param size table<number, number>
function Textures.LinearGradient(startColor, endColor, size)
    startColor = startColor or { 0, 0, 0, 255 }
    endColor = endColor or { 255, 255, 255, 255 }
    startColor[4] = startColor[4] or 255
    endColor[4] = endColor[4] or 255
    local width = size[1] or 255
    local height = size[2] or 255

    local data = ""
    local step = {}
    local stepX = (endColor[1] - startColor[1]) / width
    local stepY = (endColor[2] - startColor[2]) / height
    local stepZ = (endColor[3] - startColor[3]) / width
    local stepW = (endColor[4] - startColor[4]) / height
    for i = 0, width - 1 do
        step[1] = startColor[1] + i * stepX
        for j = 0, height - 1 do
            step[2] = startColor[2] + j * stepY
            step[3] = startColor[3] + i * stepZ
            step[4] = startColor[4] + j * stepW
            data = data .. string.char(step[1]) .. string.char(step[2]) .. string.char(step[3]) .. string.char(step[4])
        end
    end

    return data
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
