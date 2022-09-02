---@type Fonts
local Fonts = require("Library/UI/Fonts")

---@type KeyHelper
local KeyHelper = require("Library/Utils/KeyHelper")

---@class Menu
---@field public Cursor table
---@field public CursorStack table
local Menu = {
    Cursor = { X = 0, Y = 0 },
    CursorStack = Stack.new()
}

local MouseHelper = KeyHelper.new(MOUSE_LEFT)

local Windows = { }
local WindowStack = Stack.new()

local Style = {
    TitleHeight = 20,
    TitleColor = { 55, 100, 215, 255 },
    Padding = 4,
    TextColor = { 255, 255, 255, 255 },
    WindowColor = { 30, 30, 30, 255 },
}

function MouseInBound(x, y, w, h)
    local mX, mY = table.unpack(input.GetMousePos())
    return mX >= x and mX <= x + w and mY >= y and mY <= y + h
end

function Menu.Begin(title)
    if not Windows[title] then
        Windows[title] = { X = 50, Y = 50, Width = 250, Height = 250 }
    end

    local window = Windows[title]

    -- Mouse drag
    if MouseInBound(window.X, window.Y, window.Width, Style.TitleHeight) and MouseHelper:Down() then
        local mX, mY = table.unpack(input.GetMousePos())

        window.X = math.floor(mX - window.Width / 2)
        window.Y = math.floor(mY - Style.TitleHeight / 2)
    end

    Menu.Cursor.X = window.X
    Menu.Cursor.Y = window.Y + Style.TitleHeight + Style.Padding

    draw.SetFont(Fonts.Verdana)

    -- Background
    draw.Color(table.unpack(Style.WindowColor))
    draw.FilledRect(window.X, window.Y, window.X + window.Width, window.Y + window.Height)

    -- Title bar
    draw.Color(table.unpack(Style.TitleColor))
    draw.FilledRect(window.X, window.Y, window.X + window.Width, window.Y + Style.TitleHeight)

    -- Title text
    draw.Color(table.unpack(Style.TextColor))
    local titleWidth, titleHeight = draw.GetTextSize(title)
    draw.Text(math.floor(window.X + (window.Width / 2) - (titleWidth / 2)), window.Y + math.floor((20 / 2) - (titleHeight / 2)), title)

    WindowStack:push(window)
end

function Menu.End()
    local window = WindowStack:pop()
    window.Height = Menu.Cursor.Y - window.Y
end

function Menu.Text(text)
    local width, height = draw.GetTextSize(text)

    draw.Color(table.unpack(Style.TextColor))
    draw.Text(Menu.Cursor.X, Menu.Cursor.Y, text)

    Menu.Cursor.Y = Menu.Cursor.Y + height + Style.Padding
end

function Menu.Button(text)
    local txtWidth, txtHeight = draw.GetTextSize(text)
    local width, height = txtWidth + Style.Padding * 2, txtHeight + Style.Padding * 2
    local x, y = Menu.Cursor.X, Menu.Cursor.Y
    local hovered = MouseInBound(x, y, width, height)
    local clicked = hovered and MouseHelper:Pressed()

    -- Background
    if hovered then
        if MouseHelper:Down() then
            draw.Color(70, 70, 70, 255)
        else
            draw.Color(60, 60, 60, 255)
        end
    else
        draw.Color(50, 50, 50, 255)
    end
    draw.FilledRect(x, y, x + width, y + height)

    -- Text
    draw.Color(255, 255, 255, 255)
    draw.Text(math.floor(x + (width / 2) - (txtWidth / 2)), math.floor(y + (height / 2) - (txtHeight / 2)), text)

    Menu.Cursor.Y = Menu.Cursor.Y + height + Style.Padding
    return hovered and clicked
end

return Menu