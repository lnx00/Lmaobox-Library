--[[
    Simple Networking using curl
]]

---@type IO
local IO = require("Library/Utils/IO")

local function S(str)
    return "\"" .. str:gsub("\"", "'") .. "\""
end

---@class Net
local Net = { }

-- Downloads the given file/url
---@param url string
---@param path string
function Net.Download(url, path)
    os.execute("curl -o " .. S(path) .. " --url " .. S(url))
    return IO.Exists(path)
end

-- Reads the content of the given file/url
---@param url string
---@return string
function Net.Read(url)
    local handle = io.popen("curl -s " .. S(url) .. "")
    local content = handle:read("*a")
    handle:close()
    return content
end

return Net;