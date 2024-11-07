--[[
    Delayed Calls
]]

---@type { time: number, func: function }[]
local delayed_calls = {}

-- Calls the given function after the given delay
---@param delay number
---@param func function
function _G.delay_call(delay, func)
    table.insert(delayed_calls, {
        time = globals.RealTime() + delay,
        func = func
    })
end

-- Dispatches the delayed calls
---@private
local function OnDraw()
    local curTime = globals.RealTime()
    for i, call in ipairs(delayed_calls) do
        if curTime > call.time then
            table.remove(delayed_calls, i)
            call.func()
        end
    end
end

Internal.RegisterCallback("Draw", OnDraw, "DelayedCall")
