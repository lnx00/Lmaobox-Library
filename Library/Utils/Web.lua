--[[
    Simple Web library using curl
]]

local function S(str)
    return "\"" .. str:gsub("\"", "'") .. "\""
end

---@class Web
local Web = {}

-- Downloads the given file/url
---@param url string
---@param path string
function Web.Download(url, path)
    os.execute("curl -o " .. S(path) .. " --url " .. S(url))
end

-- Reads the content of the given file/url
---@param url string
---@return string | nil
function Web.Get(url)
    local handle = io.popen("curl -s -L " .. S(url) .. "")
    if not handle then return nil end

    local content = handle:read("*a")
    handle:close()
    return content
end

-- Sends a POST request with custom data
---@param url string
---@param data string
---@return string | nil
function Web.Post(url, data)
    local handle = io.popen("curl -s -L -d " .. S(data) .. " " .. S(url))
    if not handle then return nil end

    local content = handle:read("*a")
    handle:close()
    return content
end

return Web
