--[[
    KeyValues utils
]]

---@class KeyValues
local KeyValues = {}

---@param name string
---@param data table
---@param indent string
local function SerializeKV(name, data, indent)
    local lines = {}

    for key, value in pairs(data) do
        if type(value) == "table" then
            table.insert(lines, SerializeKV(key, value, indent .. "\t"))
        else
            table.insert(lines, string.format("\t%s\"%s\"\t\"%s\"", indent, key, value))
        end
    end

    local content = table.concat(lines, "\n")
    return string.format("%s\"%s\"\n%s{\n%s\n%s}", indent, name, indent, content, indent)
end

---@param name string
---@param data? table
---@return string
function KeyValues.Serialize(name, data)
    data = data or {}

    return SerializeKV(name, data, "")
end

return KeyValues
