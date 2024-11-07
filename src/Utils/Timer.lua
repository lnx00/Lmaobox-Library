---@class Timer
---@field private _last_time number
local Timer = {
    _last_time = 0
}
Timer.__index = Timer

-- Creates a new timer.
---@return Timer
function Timer.new()
    local self = setmetatable({}, Timer)
    self._last_time = 0

    return self
end

-- Checks if the timer has passed the interval.
---@param interval number
---@return boolean
function Timer:run(interval)
    if globals.CurTime() - self._last_time >= interval then
        self._last_time = globals.CurTime()
        return true
    end

    return false
end

return Timer
