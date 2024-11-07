--[[
    Custom Console Commands
]]

---@class Commands
---@field private _callbacks table<string, fun(args: Deque)>
local commands = {
    _callbacks = {}
}

---Register a new command
---@param name string
---@param callback fun(args: Deque)
function commands.register(name, callback)
    if commands._callbacks[name] ~= nil then
        warn(string.format("Command '%s' already exists and will be overwritten!", name))
    end
    commands._callbacks[name] = callback
end

---Unregister a command
---@param name string
function commands.unregister(name)
    commands._callbacks[name] = nil
end

---@param stringCmd StringCmd
local function OnStringCmd(stringCmd)
    local args = Deque.new(string.split(stringCmd:Get(), " "))
    local cmd = args:pop_front()

    if commands._callbacks[cmd] then
        stringCmd:Set("")
        commands._callbacks[cmd](args)
    end
end

Internal.RegisterCallback("SendStringCmd", OnStringCmd, "Utils", "Commands")

return commands