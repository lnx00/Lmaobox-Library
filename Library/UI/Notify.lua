--[[
    UI Notifications

    A notification can have the following attributes:
    Title, Content, Duration
]]

---@type Fonts
local Fonts = require("Library/UI/Fonts")

local Size = { W = 300, H = 50 }
local Offset = { X = 10, Y = 10 }
local Padding = { X = 10, Y = 10 }
local FadeTime = 0.3

---@class Notify
---@field private Width number
---@field private Height number
---@field private Notifications table
---@field private CurrentID number
local Notify = {
    Notifications = {},
    CurrentID = 0
}

-- Advanced notification with custom data
---@param data table
---@return integer
function Notify.Push(data)
    assert(type(data) == "table", "Notify.Push: data must be a table")

    data.ID = data.ID or Notify.CurrentID
    data.Duration = data.Duration or 3
    data.StartTime = globals.RealTime()

    table.insert(Notify.Notifications, data)
    Notify.CurrentID = Notify.CurrentID + 1

    return data.ID
end

-- Simple notification with a title
---@param title string
---@return integer
function Notify.Alert(title)
    return Notify.Push({
        Title = title
    })
end

-- Simple notification with a title and a message
---@param title string
---@param msg string
---@return integer
function Notify.Simple(title, msg)
    return Notify.Push({
        Title = title,
        Content = msg
    })
end

---@param id number
function Notify.Pop(id)
    for i, notification in pairs(Notify.Notifications) do
        if notification.ID == id then
            Notify.Notifications[i] = nil
            return
        end
    end
end

function Notify._OnDraw()
    local currentY = Offset.Y

    for i, note in pairs(Notify.Notifications) do
        local deltaTime = globals.RealTime() - note.StartTime

        if deltaTime > note.Duration then
            Notify.Notifications[i] = nil
        else
            -- Fade transition
            local fadeStep = 1.0
            if deltaTime < FadeTime then
                fadeStep = deltaTime / FadeTime
            elseif deltaTime > note.Duration - FadeTime then
                fadeStep = (note.Duration - deltaTime) / FadeTime
            end

            local fadeAlpha = math.floor(fadeStep * 255)
            currentY = currentY - math.floor((1 - fadeStep) * Size.H)

            -- Background
            draw.Color(35, 50, 60, fadeAlpha)
            draw.FilledRect(Offset.X, currentY, Offset.X + Size.W, currentY + Size.H)

            -- Duration indicator
            local barWidth = math.floor(Size.W * (deltaTime / note.Duration))
            draw.Color(255, 255, 255, 150)
            draw.FilledRect(Offset.X, currentY, Offset.X + barWidth, currentY + 5)

            draw.Color(245, 245, 245, fadeAlpha)

            -- Title Text
            draw.SetFont(Fonts.SegoeTitle)
            if note.Title then
                draw.Text(Offset.X + Padding.X, currentY + Padding.Y, note.Title)
            end

            -- Content Text
            draw.SetFont(Fonts.Segoe)
            if note.Content then
                draw.Text(Offset.X + Padding.X, currentY + Padding.Y + 20, note.Content)
            end

            currentY = currentY + Size.H + Offset.Y
        end
    end
end

return Notify
