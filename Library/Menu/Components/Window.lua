---@type Fonts
local Fonts = require("Library/UI/Fonts")

---@type Label
local Label = require("Library/Menu/Components/Label")

---@class Window
---@field public Title string
---@field public X number
---@field public Y number
---@field public Width number
---@field public Height number
---@field public Cursor table
---@field public Childs table
local Window = {
    Title = "",
    X = 0,
    Y = 0,
    Width = 200,
    Height = 200,
    Cursor = { X = 0, Y = 0 },
    Childs = { }
}
Window.__index = Window
setmetatable(Window, Window)

---@param data table
---@return Window
function Window.new(data)
    assert(type(data) == "table", "Window:new: data must be a table")

    ---@type self
    local self = setmetatable({ }, Window)
    self.Title = data.Title or "Unnamed"
    self.X = data.X or 0
    self.Y = data.Y or 0
    self.Width = data.Width or 200
    self.Height = data.Height or 200
    self.Cursor = { X = 0, Y = 0 }
    self.Childs = { }

    if data.Content then
        for key, data in pairs(data.Content) do
            if key == "Label" then
                local label = Label.new(data, self)
                table.insert(self.Childs, label)
            end
        end
    end

    return self
end

---@return number, number
function Window:GetPositon()
    return self.X, self.Y
end

function Window:Render()
    -- Background
    draw.Color(30, 30, 30, 255)
    draw.FilledRect(self.X, self.Y, self.Width, self.Height)
    draw.Color(55, 100, 215, 255)
    draw.FilledRect(self.X, self.Y, self.Width, 20)

    -- Title
    draw.SetFont(Fonts.Verdana)
    draw.Color(255, 255, 255, 255)
    local titleWidth, titleHeight = draw.GetTextSize(self.Title)
    draw.Text(math.floor(self.X + (self.Width / 2) - (titleWidth / 2)), self.Y + math.floor((20 / 2) - (titleHeight / 2)), self.Title)

    self.Cursor.X = 25
    for i, child in pairs(self.Childs) do
        local size = child:Render(self.Cursor)
        self.Cursor.X = self.Cursor.X + size.H
    end
end

return Window