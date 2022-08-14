---@class Timer
---@field private _LastTime number
local Timer = {
    _LastTime = 0
}
Timer.__index = Timer
setmetatable(Timer, Timer)

---@return Timer
function Timer.New()
    ---@type self
    local self = setmetatable({ }, Timer)
    self._LastTime = 0

    return self
end

---@param delta number
---@return boolean
function Timer:_Check(delta)
    return globals.CurTime() - self._LastTime >= delta
end

---@param interval number
---@return boolean
function Timer:Run(interval)
    if (self:_Check(interval)) then
        self._LastTime = globals.CurTime()
        return true
    end

    return false
end

return Timer