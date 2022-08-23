local Fonts = require("Library/UI/Fonts")
local Components = require("Library/Menu/Components")

---@class Window
---@field public Title string
---@field public X number
---@field public Y number
---@field public Width number
---@field public Height number
---@field public Menu Menu
---@field private Cursor table
---@field private Components Component[]
local Window = {
    Title = "",
    X = 0,
    Y = 0,
    Width = 0,
    Height = 0,
    Menu = { },

    Cursor = { X = 0, Y = 0 },
    Components = { }
}
Window.__index = Window
setmetatable(Window, Window)

---@return Window
function Window.new(menu, data)
    assert(type(data) == "table", "Window.new: data is not a table")

    ---@type self
    local self = setmetatable({ }, Window)
    self.Title = data.Title or "Unnamed"
    self.X = data.X or 0
    self.Y = data.Y or 0
    self.Width = data.Width or 200
    self.Height = data.Height or 200

    self.Cursor = { X = 0, Y = 0 }
    self.Components = { }
    self.Menu = menu

    local content = data.Content or { }
    self.Components = Components.Resolve(content)

    return self
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

    self.Cursor.Y = 25

    for i, component in pairs(self.Components) do
        local width, height = component:Render(self)
        self.Cursor.Y = self.Cursor.Y + height
    end
end

return Window