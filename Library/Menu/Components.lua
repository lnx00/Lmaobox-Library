---@class Components
---@field public Label Label
---@field public Button Button
local Components = {
    Label = require("Library/Menu/Components/Label"),
    Button = require("Library/Menu/Components/Button")
}

---@param data table
---@return Component[]
function Components.Resolve(data)
    local components = { }

    for name, itemData in pairs(data) do
        if name == "Label" then
            local label = Components.Label.new(itemData)
            table.insert(components, label)
        elseif name == "Button" then
            local button = Components.Button.new(itemData)
            table.insert(components, button)
        end
    end

    return components
end

return Components