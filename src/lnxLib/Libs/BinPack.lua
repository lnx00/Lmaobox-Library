--[[
    BinPack.lua
    A simple binary packing library for Lua
    Author: LNX (github.com/lnx00)
]]

---@class BinPack
local BinPack = {}

-- Packs multiple byte strings into a single byte string
---@vararg string
function BinPack.pack(...)
    local args = { ... }
    local result = {}

    for _, arg in ipairs(args) do
        table.insert(result, string.len(arg) .. "\0")
        table.insert(result, arg)
    end

    return table.concat(result)
end

-- Unpacks a packed byte string into multiple byte strings
---@param data string
---@return table
function BinPack.unpack(data)
    local result = {}
    local offset = 1

    while offset <= string.len(data) do
        local dataOffset = string.find(data, "\0", offset, true)
        local length = tonumber(string.sub(data, offset, dataOffset - 1))
        local value = string.sub(data, dataOffset + 1, dataOffset + length)

        offset = dataOffset + length + 1
        table.insert(result, value)
    end

    return result
end

-- Packs and saves a binary file
---@param path string
---@vararg string
---@return boolean
function BinPack.save(path, ...)
    local file = io.open(path, "wb")
    if not file then return false end

    local data = BinPack.pack(...)
    file:write(data)
    file:close()
    return true
end

-- Loads a binary file and unpacks it
---@param path string
---@return table?
function BinPack.load(path)
    local file = io.open(path, "rb")
    if not file then return nil end

    local data = file:read("*all")
    file:close()
    return BinPack.unpack(data)
end

-- Packs multiple files into a single binary file
---@param outPath string
---@vararg string
function BinPack.packFiles(outPath, ...)
    local paths = { ... }
    local files = {}

    for _, path in ipairs(paths) do
        local file = io.open(path, "rb")
        if not file then return nil end

        local data = file:read("*all")
        file:close()

        table.insert(files, data)
    end

    return BinPack.save(outPath, table.unpack(files))
end

return BinPack
