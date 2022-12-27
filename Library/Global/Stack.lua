---@class Stack
---@field private _items table
Stack = {
    _items = {}
}
Stack.__index = Stack
setmetatable(Stack, Stack)

-- Creates a new stack. | TODO: Add a constructor
---@return Stack
function Stack.new()
    ---@type Stack
    local self = setmetatable({}, Stack)
    self._items = {}

    return self
end

---@param item any
function Stack:push(item)
    table.insert(self._items, item)
end

---@return any
function Stack:pop()
    return table.remove(self._items)
end

---@return any
function Stack:peek()
    return self._items[#self._items]
end

---@return boolean
function Stack:empty()
    return #self._items == 0
end

function Stack:clear()
    self._items = {}
end

---@return number
function Stack:size()
    return #self._items
end
