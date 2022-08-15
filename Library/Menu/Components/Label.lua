---@class Label
---@field public Text string
---@field public Parent Window
local Label = {
    Text = "",
    Parent = nil
}
Label.__index = Label
setmetatable(Label, Label)

---@param data table
---@param parent Window
---@return Label
function Label.new(data, parent)
    assert(type(data) == "table", "Label:new: data must be a table")

    ---@type self
    local self = setmetatable({ }, Label)
    self.Text = data.Text or ""
    self.Parent = parent

    return self
end

---@return table
function Label:Render(cursor)
    local x, y = self.Parent:GetPositon()
    local textWidth, textHeight = draw.GetTextSize(self.Text)

    print("Y: " .. y .. ", Cursor-Y: " .. cursor.Y)
    draw.Text(x + cursor.X, y + cursor.Y, self.Text)
    return { W = textWidth, H = textHeight }
end

return Label