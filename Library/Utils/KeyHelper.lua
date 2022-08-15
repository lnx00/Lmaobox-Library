---@class KeyHelper
---@field public Key number
---@field public _LastState boolean
local KeyHelper = {
    Key = 0,
    _LastState = false
}
KeyHelper.__index = KeyHelper
setmetatable(KeyHelper, KeyHelper)

---@param key number
---@return KeyHelper
function KeyHelper.new(key)
    ---@type self
    local self = setmetatable({ }, KeyHelper)
    self.Key = key
    self._LastState = false

    return self
end

-- Is the button currently down?
---@return boolean
function KeyHelper:Down()
    local isDown = input.IsButtonDown(self.Key)
    self._LastState = isDown
    return isDown
end

-- Was the button just pressed? This will only be true once.
---@return boolean
function KeyHelper:Pressed()
    local shouldCheck = self._LastState == false
    return self:Down() and shouldCheck
end

-- Was the button just released? This will only be true once.
---@return boolean
function KeyHelper:Released()
    local shouldCheck = self._LastState == true
    return self:Down() == false and shouldCheck
end

return KeyHelper