--[[
    Input Utils
]]

---@class Input
local Input = {}

-- Contains pairs of keys and their names
---@type table<integer, string>
local KeyNames = {
    [KEY_SEMICOLON] = "SEMICOLON",
    [KEY_APOSTROPHE] = "APOSTROPHE",
    [KEY_BACKQUOTE] = "BACKQUOTE",
    [KEY_COMMA] = "COMMA",
    [KEY_PERIOD] = "PERIOD",
    [KEY_SLASH] = "SLASH",
    [KEY_BACKSLASH] = "BACKSLASH",
    [KEY_MINUS] = "MINUS",
    [KEY_EQUAL] = "EQUAL",
    [KEY_ENTER] = "ENTER",
    [KEY_SPACE] = "SPACE",
    [KEY_BACKSPACE] = "BACKSPACE",
    [KEY_TAB] = "TAB",
    [KEY_CAPSLOCK] = "CAPSLOCK",
    [KEY_INSERT] = "INSERT",
    [KEY_DELETE] = "DELETE",
    [KEY_HOME] = "HOME",
    [KEY_END] = "END",
    [KEY_PAGEUP] = "PAGEUP",
    [KEY_PAGEDOWN] = "PAGEDOWN",
    [KEY_BREAK] = "BREAK",
    [KEY_LSHIFT] = "LSHIFT",
    [KEY_RSHIFT] = "RSHIFT",
    [KEY_LALT] = "LALT",
    [KEY_RALT] = "RALT",
    [KEY_LCONTROL] = "LCONTROL",
    [KEY_RCONTROL] = "RCONTROL",
    [KEY_UP] = "UP",
    [KEY_LEFT] = "LEFT",
    [KEY_DOWN] = "DOWN",
    [KEY_RIGHT] = "RIGHT",
}

-- Contains pairs of keys and their values
---@type table<integer, string>
local KeyValues = {
    [KEY_SEMICOLON] = ";",
    [KEY_APOSTROPHE] = "'",
    [KEY_BACKQUOTE] = "`",
    [KEY_COMMA] = ",",
    [KEY_PERIOD] = ".",
    [KEY_SLASH] = "/",
    [KEY_BACKSLASH] = "\\",
    [KEY_MINUS] = "-",
    [KEY_EQUAL] = "=",
    [KEY_SPACE] = " ",
}

-- Fill the tables
local function D(x) return x, x end
for i = 1, 10 do KeyNames[i], KeyValues[i] = D(tostring(i - 1)) end -- 0 - 9
for i = 11, 36 do KeyNames[i], KeyValues[i] = D(string.char(i + 54)) end -- A - Z
for i = 37, 46 do KeyNames[i], KeyValues[i] = "KP_" .. (i - 37), tostring(i - 37) end -- KP_0 - KP_9
for i = 92, 103 do KeyNames[i] = "F" .. (i - 91) end

-- Returns the name of a key
---@param key integer
---@return string|nil
function Input.GetKeyName(key)
    return KeyNames[key]
end

-- Returns the string value of a key
---@param key integer
---@return string|nil
function Input.KeyToChar(key)
    return KeyValues[key]
end

-- Returns the key of a string value
---@param char string
---@return integer|nil
function Input.CharToKey(char)
    return table.find(KeyValues, string.upper(char))
end

-- Returns the currently pressed key
---@return integer|nil
function Input.GetPressedKey()
    for i = KEY_FIRST, KEY_LAST do
        if input.IsButtonDown(i) then return i end
    end

    return nil
end

-- Returns all currently pressed keys as a table
---@return integer[]
function Input.GetPressedKeys()
    local keys = {}
    for i = 0, 106 do
        if input.IsButtonDown(i) then table.insert(keys, i) end
    end

    return keys
end

-- Returns if the cursor is in the given bounds
---@param x integer
---@param y integer
---@param x2 integer
---@param y2 integer
---@return boolean
function Input.MouseInBounds(x, y, x2, y2)
    local mx, my = table.unpack(input.GetMousePos())
    return mx >= x and mx <= x2 and my >= y and my <= y2
end

return Input
