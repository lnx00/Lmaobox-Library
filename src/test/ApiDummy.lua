---@diagnostic disable: duplicate-set-field

local mockagne = require("test.mockagne")
dofile("test/ApiConst.lua")
dofile("test/Dummy/Vector3.lua")
dofile("test/Dummy/EulerAngles.lua")

local function Log(message)
    print(string.format("[API] %s", message))
end

---@class ApiDummy
---@field callbacks table<string, table<string, fun(...)>>
local ApiDummy = {
    callbacks = {}
}

function ApiDummy:InvokeCallback(id, ...)
    if self.callbacks[id] == nil then
        return
    end

    for _, callback in pairs(self.callbacks[id]) do
        callback(...)
    end
end

--[[ Callbacks ]]

function printc(r, g, b, a, msg, ...)
    Log("[printc] " .. string.format(msg, ...))
end

callbacks = mockagne.getMock("Callbacks")

function callbacks.Register(id, name, callback)
    if ApiDummy.callbacks[id] == nil then
        ApiDummy.callbacks[id] = {}
    end

    ApiDummy.callbacks[id][name] = callback
    Log("Registered callback " .. name .. " for " .. id)
end

function callbacks.Unregister(id, name)
    if ApiDummy.callbacks[id] == nil then
        return
    end

    ApiDummy.callbacks[id][name] = nil
    Log("Unregistered callback " .. name .. " for " .. id)
end

draw = mockagne.getMock("Draw")
engine = mockagne.getMock("Engine")
filesystem = mockagne.getMock("FileSystem")
globals = mockagne.getMock("Globals")

mockagne.when(engine.GetGameDir()).thenAnswer("GameDir")

return ApiDummy