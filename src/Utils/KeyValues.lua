--[[
    KeyValues utils
]]

---@class KeyValues
local kv = {}

---@param name string
---@param data table
---@param indent string
local function serialize_kv(name, data, indent)
    local bodyData = {}

    for key, value in pairs(data) do
        if type(value) == "table" then
            table.insert(bodyData, serialize_kv(key, value, indent .. "\t"))
        else
            table.insert(bodyData, string.format("\t%s\"%s\"\t\"%s\"", indent, key, value))
        end
    end

    local body = table.concat(bodyData, "\n")
    return string.format("%s\"%s\"\n%s{\n%s\n%s}", indent, name, indent, body, indent)
end

---@return table
local function deserialize_kv(data)
    local result = {}

    for key, value in data:gmatch('"(.-)"%s*"(.-)"') do
        result[key] = value
    end

    return result
end

---@param name string
---@param data? table
---@return string
function kv.serialize(name, data)
    data = data or {}

    return serialize_kv(name, data, "")
end

---@param data string
---@return string name, table data
function kv.deserialize(data)
    local name, content = data:match('"(.-)"%s*{([^}]-)}')
    return name, deserialize_kv(content)
end

return kv
