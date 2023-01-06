--[[
    Internal functions for the library.
]]

local oldInternal = rawget(_G, "Internal")

---@class Internal
_G.Internal = {}

-- (Re-)Registers a callback with a given namespace
---@param name string
---@param callback fun()
---@vararg string
function Internal.RegisterCallback(name, callback, ...)
    local id = table.concat({"LNXlib", ..., name}, ".")
    callbacks.Unregister(name, id)
    callbacks.Register(name, id, callback)
    print("Registered callback: " .. name .. " (" .. id .. ")")
end

-- Removes all internal functions
function Internal.Cleanup()
    _G.Internal = oldInternal
end