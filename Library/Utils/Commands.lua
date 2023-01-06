--[[
    Custom Console Commands
]]

---@class Commands
---@field _Commands table<string, fun(args : Deque)>
local Commands = {
    _Commands = {}
}

-- Register a new command
---@param name string
---@param callback fun(args : Deque)
function Commands.Register(name, callback)
    -- TODO: Check for override
    Commands._Commands[name] = callback
end

-- Unregister a command
---@param name string
function Commands.Unregister(name)
    Commands._Commands[name] = nil
end

---@param stringCmd StringCmd
local function OnStringCmd(stringCmd)
    local args = Deque.new(string.split(stringCmd:Get(), " "))
    local cmd = args:popFront()
    
    if Commands._Commands[cmd] then
        stringCmd:Set("")
        Commands._Commands[cmd](args)
    end
end

Internal.RegisterCallback("SendStringCmd", OnStringCmd, "Utils", "Commands")

return Commands