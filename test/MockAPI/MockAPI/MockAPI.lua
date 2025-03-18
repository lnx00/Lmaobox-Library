---@diagnostic disable: duplicate-set-field

Mockagne = require("MockAPI.mockagne")

local function Log(message)
    print(string.format("[MockAPI] %s", message))
end

-- Constants
dofile("MockAPI/Globals.lua")
dofile("MockAPI/Enums.lua")

-- Classes
dofile("MockAPI/Classes/Vector3.lua")
dofile("MockAPI/Classes/EulerAngles.lua")

-- Libraries
aimbot = Mockagne.getMock("Aimbot")
callbacks = Mockagne.getMock("Callbacks")
client = Mockagne.getMock("Client")
clientstate = Mockagne.getMock("Clientstate")
draw = Mockagne.getMock("Draw")
engine = Mockagne.getMock("Engine")
entities = Mockagne.getMock("Entities")
filesystem = Mockagne.getMock("FileSystem")
gamecoordinator = Mockagne.getMock("GameCoordinator")
gamerules = Mockagne.getMock("GameRules")
globals = Mockagne.getMock("Globals")
gui = Mockagne.getMock("GUI")
http = Mockagne.getMock("HTTP")
input = Mockagne.getMock("Input")
inventory = Mockagne.getMock("Inventory")
itemschema = Mockagne.getMock("ItemSchema")
materials = Mockagne.getMock("Materials")
models = Mockagne.getMock("Models")
party = Mockagne.getMock("Party")
physics = Mockagne.getMock("Physics")
playerlist = Mockagne.getMock("PlayerList")
steam = Mockagne.getMock("Steam")
warp = Mockagne.getMock("Warp")

---@class MockAPI
---@field callbacks table<string, table<string, fun(...)>>
local MockAPI = {
    callbacks = {},
}

--[[ Callback invocation ]]

function MockAPI:InvokeCallback(id, ...)
    if self.callbacks[id] == nil then
        return
    end

    for name, callback in pairs(self.callbacks[id]) do
        Log("Invoking callback " .. name .. " for " .. id)
        callback(...)
    end
end

function callbacks.Register(id, name, callback)
    if MockAPI.callbacks[id] == nil then
        MockAPI.callbacks[id] = {}
    end

    MockAPI.callbacks[id][name] = callback
    Log("Registered callback " .. name .. " for " .. id)
end

function callbacks.Unregister(id, name)
    if MockAPI.callbacks[id] == nil then
        return
    end

    MockAPI.callbacks[id][name] = nil
    Log("Unregistered callback " .. name .. " for " .. id)
end

return MockAPI
