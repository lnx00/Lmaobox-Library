---@class Textures
local textures = {}

---@alias TColor table<integer, integer, integer, integer?>
---@alias TSize table<integer, integer>

local byteMap = {}
for i = 0, 255 do byteMap[i] = string.char(i) end

---@param color TColor
---@return integer, integer, integer, integer
local function unpack_color(color)
    local r, g, b, a = table.unpack(color)
    a = a or 255
    return r, g, b, a
end

---@param size TSize
---@return integer, integer
local function unpack_size(size)
    return size[1] or 256, size[2] or 256
end

-- Creates and caches the texture from RGBA data
---@param width integer
---@param height integer
---@param data table
local function create_tex(width, height, data)
    local binaryData = table.concat(data)
    return draw.CreateTextureRGBA(binaryData, width, height)
end

-- [PERFORMANCE INTENSIVE] Creates a linear gradient
---@param startColor TColor
---@param endColor TColor
---@param size TSize
---@return TextureID
---@nodiscard
function textures.linear_gradient(startColor, endColor, size)
    local sR, sG, sB, sA = unpack_color(startColor)
    local eR, eG, eB, eA = unpack_color(endColor)
    local w, h = unpack_size(size)

    local dataSize = w * h * 4
    local data, bm = {}, byteMap
    
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

    return create_tex(w, h, data)
end

-- [PERFORMANCE INTENSIVE] Creates a circle with a given color
---@param radius number
---@param color table<number, number, number, number>
---@return TextureID
---@nodiscard
function textures.circle(radius, color)
    local r, g, b, a = unpack_color(color)

    local diameter = radius * 2
    local dataSize = diameter * diameter * 4
    local data, bm = {}, byteMap

    local i = 1
    while i < dataSize do
        local idx = (i / 4)
        local x, y = idx % diameter, idx // diameter
        local dx, dy = x - radius, y - radius
        local dist = math.sqrt(dx * dx + dy * dy)

        if dist <= radius then
            data[i] = bm[r]
            data[i + 1] = bm[g]
            data[i + 2] = bm[b]
            data[i + 3] = bm[a]
        else
            data[i] = bm[0]
            data[i + 1] = bm[0]
            data[i + 2] = bm[0]
            data[i + 3] = bm[0]
        end

        i = i + 4
    end

    return create_tex(diameter, diameter, data)
end

return textures
