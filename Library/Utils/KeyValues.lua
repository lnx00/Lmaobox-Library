--[[
    KeyValues utils
]]

---@class KeyValues
local KeyValues = {}

---@param name string
---@param data table
---@param indent string
local function SerializeKV(name, data, indent)
    local bodyData = {}

    for key, value in pairs(data) do
        if type(value) == "table" then
            table.insert(bodyData, SerializeKV(key, value, indent .. "\t"))
        else
            table.insert(bodyData, string.format("\t%s\"%s\"\t\"%s\"", indent, key, value))
        end
    end

    local body = table.concat(bodyData, "\n")
    return string.format("%s\"%s\"\n%s{\n%s\n%s}", indent, name, indent, body, indent)
end

local function ParseKV(data, result)
    local name, body = data:match("\"(.+)\"\n%s*{(.+)}")
    if not name then
        return
    end

    local bodyData = {}

    for key, value in body:gmatch("\"(.+)\"\t\"(.+)\"") do
        bodyData[key] = value
    end

    result[name] = bodyData

    ParseKV(data:sub(#name + #body + 4), result)
end

---@param data string
---@return table
local function DeserializeKV(data)
    local result = {}

    ParseKV(data, result)

    return result
end

---@param name string
---@param data? table
---@return string
function KeyValues.Serialize(name, data)
    data = data or {}

    return SerializeKV(name, data, "")
end

---@param data string
---@return table
function KeyValues.Deserialize(data)
    return DeserializeKV(data)
end

return KeyValues
