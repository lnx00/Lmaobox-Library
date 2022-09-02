---@type Fonts
local Fonts = require("Library/UI/Fonts")

---@class Menu
---@field public Cursor table
---@field public CursorStack table
local Menu = {
    Cursor = { X = 0, Y = 0 },
    CursorStack = Stack.new()
}

local Windows = { }
local WindowStack = Stack.new()

local Style = {
    TitleSize = 20,
    Padding = 4
}

function Menu.Begin(title)
    if not Windows[title] then
        Windows[title] = { X = 50, Y = 50, Width = 250, Height = 250 }
    end

    local window = Windows[title]

    -- Mouse drag
    if input.IsButtonDown(MOUSE_LEFT) then
        local mX, mY = table.unpack(input.GetMousePos())

        if mX > window.X and mX < window.X + window.Width and mY > window.Y and mY < window.Y + Style.TitleSize then
            window.X = math.floor(mX - window.Width / 2)
            window.Y = math.floor(mY - Style.TitleSize / 2)
        end
    end

    Menu.Cursor.X = window.X + Style.Padding
    Menu.Cursor.Y = window.Y + Style.TitleSize + Style.Padding

    draw.SetFont(Fonts.Verdana)

    -- Background
    draw.Color(30, 30, 30, 255)
    draw.FilledRect(window.X, window.Y, window.X + window.Width, window.Y + window.Height)

    -- Title bar
    draw.Color(55, 100, 215, 255)
    draw.FilledRect(window.X, window.Y, window.X + window.Width, window.Y + Style.TitleSize)

    -- Title text
    draw.Color(255, 255, 255, 255)
    local titleWidth, titleHeight = draw.GetTextSize(title)
    draw.Text(math.floor(window.X + (window.Width / 2) - (titleWidth / 2)), window.Y + math.floor((20 / 2) - (titleHeight / 2)), title)

    draw.Color(255, 255, 255, 255)
    WindowStack:push(window)

    -- TODO: Update WindowPos on drag
end

function Menu.End()
    local window = WindowStack:pop()
    window.Height = Menu.Cursor.Y - window.Y
end

function Menu.Text(text)
    local width, height = draw.GetTextSize(text)
    draw.Text(Menu.Cursor.X, Menu.Cursor.Y, text)

    Menu.Cursor.Y = Menu.Cursor.Y + height + Style.Padding
end

return Menu