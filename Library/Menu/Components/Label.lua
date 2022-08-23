local Component = require("Library/Menu/Components/Component")

---@class Label : Component
---@field public Text string
local Label = {
    Text = ""
}
Label.__index = Label
setmetatable(Label, Component)

---@return Label
function Label.new(data)
    assert(type(data) == "table", "Label.new: data must be a table")

    ---@type self
    local self = setmetatable({ }, Label)
    self.Text = data.Text or ""

    return self
end

function Label:Render(window)
    local cursor = window.Cursor
    local lblWidth, lblHeight = draw.GetTextSize(self.Text)

    draw.Text(window.X + cursor.X, window.Y + cursor.Y, self.Text)
    return lblWidth, lblHeight
end

return Label