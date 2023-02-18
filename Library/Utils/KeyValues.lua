--[[
    KeyValues wrapper
]]

---@class KeyValues
local KeyValues = {
    Name = "",
    _Content = {}
}
KeyValues.__index = KeyValues
setmetatable(KeyValues, KeyValues)

-- Serializes a KeyValues object
---@param keyValues table
---@param indent string
---@return string
local function SerializeKV(keyValues, indent)
    local data = {}

    for key, value in pairs(keyValues) do
        if type(value) == "table" then
            table.insert(data, string.format("%s\"%s\"\n%s{\n%s\n%s}", indent, key, indent, SerializeKV(value, indent .. "\t"), indent))
        else
            table.insert(data, string.format("%s\"%s\"\t\"%s\"", indent, key, value))
        end
    end

    return table.concat(data, "\n")
end

-- Creates a new KeyValues object
---@param name string
---@return KeyValues
function KeyValues.new(name)
    local self = setmetatable({}, KeyValues)
    self.Name = name
    self._Content = {}

    return self
end

-- Returns the KeyValues as a string
---@return string
function KeyValues:__tostring()
    return SerializeKV({ [self.Name] = self._Content }, "")
end

return KeyValues
