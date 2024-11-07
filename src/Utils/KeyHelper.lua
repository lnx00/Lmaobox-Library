---@class KeyHelper
---@field public key integer
---@field private _last_state boolean
local KeyHelper = {
    key = 0,
    _last_state = false
}
KeyHelper.__index = KeyHelper

-- Creates a new key helper
---@param key integer
---@return KeyHelper
function KeyHelper.new(key)
    local self = setmetatable({}, KeyHelper)
    self.key = key
    self._last_state = false

    return self
end

-- Is the button currently down?
---@return boolean
function KeyHelper:down()
    local isDown = input.IsButtonDown(self.key)
    return isDown
end

-- Was the button just pressed? This will only be true once.
---@return boolean
function KeyHelper:pressed()
    local shouldCheck = self._last_state == false
    self._last_state = self:down()
    return self._last_state and shouldCheck
end

-- Was the button just released? This will only be true once.
---@return boolean
function KeyHelper:released()
    local shouldCheck = self._last_state == true
    self._last_state = self:down()
    return self._last_state == false and shouldCheck
end

return KeyHelper
