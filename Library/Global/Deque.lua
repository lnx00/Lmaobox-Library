--[[
    Double ended queue data structure
]]

-- Double ended queue
---@class Deque
---@field private _items table
---@field private _size integer
Deque = {
    _items = {},
    _size = 0
}
Deque.__index = Deque
setmetatable(Deque, Deque)

-- Creates a new deque.
---@param items? any[]
---@return Deque
function Deque.new(items)
    ---@type Deque
    local self = setmetatable({}, Deque)
    self._items = items or {}
    self._size = #self._items

    return self
end

---@param item any
function Deque:pushFront(item)
    table.insert(self._items, 1, item)
    self._size = self._size + 1
end

---@param item any
function Deque:pushBack(item)
    table.insert(self._items, item)
    self._size = self._size + 1
end

---@return any
function Deque:popFront()
    self._size = self._size - 1
    return table.remove(self._items, 1)
end

---@return any
function Deque:popBack()
    self._size = self._size - 1
    return table.remove(self._items)
end

---@return any
function Deque:peekFront()
    return self._items[1]
end

---@return any
function Deque:peekBack()
    return self._items[self._size]
end

---@return boolean
function Deque:empty()
    return self._size == 0
end

function Deque:clear()
    self._items = {}
    self._size = 0
end

---@return integer
function Deque:size()
    return self._size
end

-- Returns the items table as read-only
---@return any[]
function Deque:items()
    return table.readOnly(self._items)
end
