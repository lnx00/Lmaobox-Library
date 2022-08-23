local Component = require("Library/Menu/Components/Component")

---@class Button : Component
---@field public Text string
local Button = {
    Text = "",
    OnClick = nil
}
Button.__index = Button
setmetatable(Button, Component)

---@return Button
function Button.new(data)
    assert(type(data) == "table", "Button.new: data must be a table")

    ---@type self
    local self = setmetatable({ }, Button)
    self.Text = data.Text or ""
    self.OnClick = data.OnClick or function() end

    return self
end

function Button:Render(window)
    local cursor = window.Cursor
    local lblWidth, lblHeight = draw.GetTextSize(self.Text)
    local btnWidth, btnHeight = lblWidth + 10, lblHeight + 10

    draw.Color(50, 50, 50, 255)
    draw.FilledRect(window.X + cursor.X, window.Y + cursor.Y, window.X + cursor.X + btnWidth, window.Y + cursor.Y + btnHeight)
    draw.Color(255, 255, 255, 255)
    draw.Text(math.floor(window.X + cursor.X + (btnWidth / 2) - (lblWidth / 2)), math.floor(window.Y + cursor.Y + (btnHeight / 2) - (lblHeight / 2)), self.Text)

    return btnWidth, btnHeight
end

return Button