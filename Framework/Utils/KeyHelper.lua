local KeyHelper = {
    Key = 0,
    LastState = false
}
KeyHelper.__index = KeyHelper
setmetatable(KeyHelper, KeyHelper)

function KeyHelper.FromKey(key)
    local self = setmetatable({ }, KeyHelper)
    self.Key = key
    self.LastState = false

    return self
end

-- Is the button currently down?
function KeyHelper:Down()
    local isDown = input.IsButtonDown(self.Key)
    self.LastState = isDown
    return isDown
end

-- Was the button just pressed? This will only be true once.
function KeyHelper:Pressed()
    local shouldCheck = self.LastState == false
    return self:Down() and shouldCheck
end

-- Was the button just released? This will only be true once.
function KeyHelper:Released()
    local shouldCheck = self.LastState == true
    return self:Down() == false and shouldCheck
end

return KeyHelper