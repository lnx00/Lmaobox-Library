local Timer = {
    LastTime = 0
}
Timer.__index = Timer
setmetatable(Timer, Timer)

function Timer.New()
    local self = setmetatable({ }, Timer)
    self.LastTime = 0

    return self
end

function Timer:_Check(delta)
    return globals.CurTime() - self.LastTime >= delta
end

function Timer:Run(interval)
    if (self:_Check(interval)) then
        self.LastTime = globals.CurTime()
        return true
    end

    return false
end

return Timer