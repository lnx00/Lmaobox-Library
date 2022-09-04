---@type Fonts
local Fonts = require("Library/UI/Fonts")

---@type KeyHelper
local KeyHelper = require("Library/Utils/KeyHelper")

---@class Menu
---@field public Cursor table
local Menu = {
    Cursor = { X = 0, Y = 0 },
}

local MouseHelper = KeyHelper.new(MOUSE_LEFT)
local EnterHelper = KeyHelper.new(KEY_ENTER)

local CursorStack = Stack.new()

local Windows = { }
local WindowStack = Stack.new()

---@type table
local LastSize = { W = 0, H = 0 }

-- Current Colors of the Menu
local Colors = {
    Title = { 55, 100, 215, 255 },
    Text = { 255, 255, 255, 255 },
    Window = { 30, 30, 30, 255 },
    Item = { 50, 50, 50, 255 },
    ItemHover = { 60, 60, 60, 255 },
    ItemActive = { 70, 70, 70, 255 },
    Highlight = { 255, 255, 255, 150 },
}
local ColorStack = Stack.new()

-- Current Style of the Menu
local Style = {
    Spacing = 5,
    ItemSize = 20,
}
local StyleStack = Stack.new()

function MouseInBound(x, y, w, h)
    local mX, mY = table.unpack(input.GetMousePos())
    return mX >= x and mX <= x + w and mY >= y and mY <= y + h
end

function Menu.GetStyle()
    return Style
end

function Menu.GetColors()
    return Colors
end

-- Sets the next color to be used
---@param color table
function Menu.SetNextColor(color)
    color[4] = color[4] or 255
    draw.Color(table.unpack(color))
end

-- Updates the next color depending on the interaction state
---@param hovered boolean
---@param active boolean
function Menu.InteractionColor(hovered, active)
    if active then
        Menu.SetNextColor(Colors.ItemActive)
    elseif hovered then
        Menu.SetNextColor(Colors.ItemHover)
    else
        Menu.SetNextColor(Colors.Item)
    end
end

-- Returns whether the element is clicked or active
---@param hovered boolean
function Menu.GetInteraction(hovered)
    local clicked = hovered and (MouseHelper:Pressed() or EnterHelper:Pressed())
    local active = hovered and (MouseHelper:Down() or EnterHelper:Down())

    return clicked, active
end

-- Update the cursor after drawing a component
function Menu.UpdateCursor(width, height)
    Menu.Cursor.Y = Menu.Cursor.Y + height + Style.Spacing
    LastSize.W, LastSize.H = width, height
end

-- Push a style to the stack
function Menu.PushStyle(key, value)
    StyleStack:push({ Key = key, Value = Style[key] })
    Style[key] = value
end

-- Pop the last style from the stack
function Menu.PopStyle(amount)
    amount = amount or 1
    for i = 1, amount do
        local style = StyleStack:pop()
        Style[style.Key] = style.Value
    end
end

-- Push a color to the stack
function Menu.PushColor(key, value)
    ColorStack:push({ Key = key, Value = Colors[key] })
    Colors[key] = value
end

-- Pop the last color from the stack
function Menu.PopColor(amount)
    amount = amount or 1
    for i = 1, amount do
        local color = ColorStack:pop()
        Colors[color.Key] = color.Value
    end
end

function Menu.Begin(title)
    if not Windows[title] then
        Windows[title] = { X = 50, Y = 50, Width = 250, Height = 250 }
    end

    local window = Windows[title]
    draw.SetFont(Fonts.Verdana)
    local txtWidth, txtHeight = draw.GetTextSize(title)
    local titleHeight = txtHeight + Style.Spacing

    -- Mouse drag
    if MouseInBound(window.X, window.Y, window.Width, titleHeight) and MouseHelper:Down() then
        local mX, mY = table.unpack(input.GetMousePos())

        window.X = math.floor(mX - (window.Width / 2))
        window.Y = math.floor(mY - (titleHeight / 2))
    end

    Menu.Cursor.X = window.X
    Menu.Cursor.Y = window.Y + titleHeight + Style.Spacing

    -- Background
    draw.Color(table.unpack(Colors.Window))
    draw.FilledRect(window.X, window.Y, window.X + window.Width, window.Y + window.Height)

    -- Title bar
    draw.Color(table.unpack(Colors.Title))
    draw.OutlinedRect(window.X, window.Y, window.X + window.Width, window.Y + window.Height)
    draw.FilledRect(window.X, window.Y, window.X + window.Width, window.Y + titleHeight)

    -- Title text
    draw.Color(table.unpack(Colors.Text))
    draw.Text(math.floor(window.X + (window.Width / 2) - (txtWidth / 2)), window.Y + math.floor((20 / 2) - (txtHeight / 2)), title)

    WindowStack:push(window)
end

function Menu.End()
    local window = WindowStack:pop()
    window.Height = Menu.Cursor.Y - window.Y
end

function Menu.Text(text)
    local width, height = draw.GetTextSize(text)
    local x, y = Menu.Cursor.X + Style.Spacing, Menu.Cursor.Y

    draw.Color(table.unpack(Colors.Text))
    draw.Text(x, y, text)

    Menu.UpdateCursor(width, height)
end

function Menu.Button(text)
    local txtWidth, txtHeight = draw.GetTextSize(text)
    local width, height = txtWidth + Style.Spacing * 2, txtHeight + Style.Spacing * 2
    local x, y = Menu.Cursor.X + Style.Spacing, Menu.Cursor.Y
    local hovered = MouseInBound(x, y, width, height)
    local clicked, active = Menu.GetInteraction(hovered)

    -- Background
    Menu.InteractionColor(hovered, active)
    draw.FilledRect(x, y, x + width, y + height)

    -- Text
    draw.Color(table.unpack(Colors.Text))
    draw.Text(math.floor(x + (width / 2) - (txtWidth / 2)), math.floor(y + (height / 2) - (txtHeight / 2)), text)

    Menu.UpdateCursor(width, height)
    return hovered and clicked, active
end

-- Draws a checkbox that toggles a value
---@param text string
---@param state boolean
---@return boolean, boolean
function Menu.Checkbox(text, state)
    local txtWidth, txtHeight = draw.GetTextSize(text)
    local x, y = Menu.Cursor.X + Style.Spacing, Menu.Cursor.Y
    local hovered = MouseInBound(x, y, Style.ItemSize, Style.ItemSize)
    local clicked, active = Menu.GetInteraction(hovered)

    -- Box
    Menu.InteractionColor(hovered, active)
    draw.FilledRect(x, y, x + Style.ItemSize, y + Style.ItemSize)

    if state then
        draw.Color(table.unpack(Colors.Highlight))
        draw.FilledRect(x + Style.Spacing, y + Style.Spacing, x + (Style.ItemSize - Style.Spacing), y + (Style.ItemSize - Style.Spacing))
    end

    -- Text
    draw.Color(table.unpack(Colors.Text))
    draw.Text(x + Style.ItemSize + Style.Spacing, math.floor(y + (Style.ItemSize / 2) - (txtHeight / 2)), text)

    -- Update State
    if clicked then
        state = not state
    end

    Menu.UpdateCursor(20 + txtWidth, math.max(20, txtHeight))
    return state, clicked
end

---@param size number
function Menu.Space(size)
    size = size or Style.Spacing
    Menu.UpdateCursor(size, size)
end

function Menu.SameLine()
    Menu.Cursor.X = Menu.Cursor.X + LastSize.W + Style.Spacing
    Menu.Cursor.Y = Menu.Cursor.Y - LastSize.H - Style.Spacing
end

return Menu