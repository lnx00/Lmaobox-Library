--[[
    Filesystem Utils
]]

---@class FS
local FS = { }
local WorkDir = engine.GetGameDir() .. "/../LNXlib/"

-- Reads a file and returns its contents
---@param path string
---@return any
function FS.Read(path)
    local file = io.open(path, "rb") -- r read mode and b binary mode
    if not file then return nil end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return content
end

-- Writes the given content to the given file path
---@param path string
---@param content any
---@return boolean
function FS.Write(path, content)
    local file = io.open(path, "wb") -- w write mode and b binary mode
    if not file then return false end
    file:write(content)
    file:close()
    return true
end

-- Deletes the file at the given path
---@param path string
function FS.Delete(path)
    os.remove(path)
end

-- Returns whether the given file/directory exists
---@param path string
---@return boolean
function FS.Exists(path)
    local file = io.open(path, "rb")
    if file then file:close() end
    return file ~= nil
end

-- Returns the working directory
---@return string
function FS.GetWorkDir()
    if not FS.Exists(WorkDir) then
        filesystem.CreateDirectory(WorkDir)
    end

    return WorkDir
end

return FS