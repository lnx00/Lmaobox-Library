--[[
    Delayed Calls
]]

local delayedCalls = { }

-- Calls the given function after the given delay
---@param delay number
---@param func fun()
function _G.DelayedCall(delay, func)
    table.insert(delayedCalls, {
        time = globals.RealTime() + delay,
        thread = coroutine.create(func)
    })
end

-- Dispatches the delayed calls
---@private
local function OnDraw()
    local curTime = globals.RealTime()
    for i, call in ipairs(delayedCalls) do
        if curTime > call.time then
            coroutine.resume(call.thread)
            table.remove(delayedCalls, i)
        end
    end
end

callbacks.Unregister("Draw", "LBL_DC_Draw")
callbacks.Register("Draw", "LBL_DC_Draw", OnDraw)