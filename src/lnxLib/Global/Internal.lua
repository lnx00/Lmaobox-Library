--[[
    Internal functions for the library.
]]
local oldInternal = rawget(_G, "Internal")

---@class Internal
_G.Internal = {}

-- (Re-)Registers a callback with a given namespace
---@param id CallbackID
---@param callback fun()
---@vararg string
function Internal.RegisterCallback(id, callback, ...)
    local name = table.concat({ "lnxLib", ..., id }, ".")
    callbacks.Unregister(id, name)
    callbacks.Register(id, name, callback)
end

-- Removes all internal functions
function Internal.Cleanup()
    _G.Internal = oldInternal
end
