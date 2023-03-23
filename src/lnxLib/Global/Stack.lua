--[[
    Stack data structure
]]

---@class Stack
---@field private _items table
---@field private _size integer
Stack = {
    _items = {},
    _size = 0
}
Stack.__index = Stack
setmetatable(Stack, Stack)

-- Creates a new stack.
---@param items? any[]
---@return Stack
function Stack.new(items)
    ---@type Stack
    local self = setmetatable({}, Stack)
    self._items = items or {}
    self._size = #self._items

    return self
end

---@param item any
function Stack:push(item)
    self._size = self._size + 1
    self._items[self._size] = item
end

---@return any
function Stack:pop()
    self._size = self._size - 1
    return table.remove(self._items)
end

---@return any
function Stack:peek()
    return self._items[self._size]
end

---@return boolean
function Stack:empty()
    return self._size == 0
end

function Stack:clear()
    self._items = {}
    self._size = 0
end

---@return integer
function Stack:size()
    return self._size
end

-- Returns the items in the stack
---@return any[]
function Stack:items()
    return table.readOnly(self._items)
end
