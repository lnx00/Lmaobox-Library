--[[
    Filesystem Utils
]]

local IO = { }
local WorkDir = engine.GetGameDir() .. "/../LNXF/"

-- Reads a file and returns its contents
function IO.ReadFile(path)
    local file = io.open(path, "rb") -- r read mode and b binary mode
    if not file then return nil end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return content
end

-- Writes the given content to the given file path
function IO.WriteFile(path, content)
    local file = io.open(path, "wb") -- w write mode and b binary mode
    if not file then return nil end
    file:write(content)
    file:close()
    return true
end

-- Returns whether the given file/directory exists
function IO.Exists(path)
    local file = io.open(path, "rb")
    if file then file:close() end
    return file ~= nil
end

-- Returns the working directory
function IO.GetWorkDir()
    if not IO.Exists(WorkDir) then
        filesystem.CreateDirectory(WorkDir)
    end

    return WorkDir
end

return IO