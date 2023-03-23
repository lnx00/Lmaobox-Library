--[[
    Delayed Calls
]]

---@type { time : number, func : fun() }[]
local delayedCalls = {}

-- Calls the given function after the given delay
---@param delay number
---@param func fun()
function _G.DelayedCall(delay, func)
    table.insert(delayedCalls, {
        time = globals.RealTime() + delay,
        func = func
    })
end

-- Dispatches the delayed calls
---@private
local function OnDraw()
    local curTime = globals.RealTime()
    for i, call in ipairs(delayedCalls) do
        if curTime > call.time then
            table.remove(delayedCalls, i)
            call.func()
        end
    end
end

Internal.RegisterCallback("Draw", OnDraw, "DelayedCall")
