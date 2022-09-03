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

local Style = {
    Spacing = 5,
    ItemSize = 20,
    TitleColor = { 55, 100, 215, 255 },
    TextColor = { 255, 255, 255, 255 },
    WindowColor = { 30, 30, 30, 255 },
    ItemColor = { 50, 50, 50, 255 },
    ItemHoverColor = { 60, 60, 60, 255 },
    ItemActiveColor = { 70, 70, 70, 255 },
    HighlightColor = { 255, 255, 255, 150 },
}
local StyleStack = Stack.new()

function MouseInBound(x, y, w, h)
    local mX, mY = table.unpack(input.GetMousePos())
    return mX >= x and mX <= x + w and mY >= y and mY <= y + h
end

function SetItemColor(hovered, active)
    if active then
        draw.Color(table.unpack(Style.ItemActiveColor))
    elseif hovered then
        draw.Color(table.unpack(Style.ItemHoverColor))
    else
        draw.Color(table.unpack(Style.ItemColor))
    end
end

function GetInteraction(hovered)
    local clicked = hovered and (MouseHelper:Pressed() or EnterHelper:Pressed())
    local active = hovered and (MouseHelper:Down() or EnterHelper:Down())

    return clicked, active
end

function UpdateCursor(width, height)
    Menu.Cursor.Y = Menu.Cursor.Y + height + Style.Spacing
    LastSize.W, LastSize.H = width, height
end

function Menu.PushStyle(key, value)
    StyleStack:push({ Key = key, Value = Style[key] })
    Style[key] = value
end

function Menu.PopStyle()
    local style = StyleStack:pop()
    Style[style.Key] = style.Value
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
    draw.Color(table.unpack(Style.WindowColor))
    draw.FilledRect(window.X, window.Y, window.X + window.Width, window.Y + window.Height)

    -- Title bar
    draw.Color(table.unpack(Style.TitleColor))
    draw.FilledRect(window.X, window.Y, window.X + window.Width, window.Y + titleHeight)

    -- Title text
    draw.Color(table.unpack(Style.TextColor))
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

    draw.Color(table.unpack(Style.TextColor))
    draw.Text(x, y, text)

    UpdateCursor(width, height)
end

function Menu.Button(text)
    local txtWidth, txtHeight = draw.GetTextSize(text)
    local width, height = txtWidth + Style.Spacing * 2, txtHeight + Style.Spacing * 2
    local x, y = Menu.Cursor.X + Style.Spacing, Menu.Cursor.Y
    local hovered = MouseInBound(x, y, width, height)
    local clicked, active = GetInteraction(hovered)

    -- Background
    SetItemColor(hovered, down)
    draw.FilledRect(x, y, x + width, y + height)

    -- Text
    draw.Color(table.unpack(Style.TextColor))
    draw.Text(math.floor(x + (width / 2) - (txtWidth / 2)), math.floor(y + (height / 2) - (txtHeight / 2)), text)

    UpdateCursor(width, height)
    return hovered and clicked, active
end

function Menu.Checkbox(text, state)
    local txtWidth, txtHeight = draw.GetTextSize(text)
    local x, y = Menu.Cursor.X + Style.Spacing, Menu.Cursor.Y
    local hovered = MouseInBound(x, y, Style.ItemSize, Style.ItemSize)
    local clicked, active = GetInteraction(hovered)

    -- Box
    SetItemColor(hovered, active)
    draw.FilledRect(x, y, x + Style.ItemSize, y + Style.ItemSize)

    if state then
        draw.Color(table.unpack(Style.HighlightColor))
        draw.FilledRect(x + Style.Spacing, y + Style.Spacing, x + (Style.ItemSize - Style.Spacing), y + (Style.ItemSize - Style.Spacing))
    end

    -- Text
    draw.Color(table.unpack(Style.TextColor))
    draw.Text(x + Style.ItemSize + Style.Spacing, math.floor(y + (Style.ItemSize / 2) - (txtHeight / 2)), text)

    -- Update State
    if clicked then
        state = not state
    end

    UpdateCursor(20 + txtWidth, math.max(20, txtHeight))
    return state, clicked
end

function Menu.Space(size)
    size = size or Style.Spacing
    UpdateCursor(size, size)
end

function Menu.SameLine()
    Menu.Cursor.X = Menu.Cursor.X + LastSize.W + Style.Spacing
    Menu.Cursor.Y = Menu.Cursor.Y - LastSize.H - Style.Spacing
end

return Menu