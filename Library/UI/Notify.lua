--[[
    UI Notifications

    A notification can have the following attributes:
    Title, Content, Duration
]]

---@type Fonts
local Fonts = require(LIB_PATH .. "UI/Fonts")

local Size = { W = 300, H = 60 }
local Offset = { X = 10, Y = 10 }
local Padding = { X = 10, Y = 10 }

---@class Notify
---@field private Width number
---@field private Height number
---@field private Notifications table
---@field private CurrentID number
local Notify = {
    Notifications = { },
    CurrentID = 0
}

---@param data table
function Notify.Push(data)
    assert(type(data) == "table", "Notify.Push: data must be a table")

    -- Set the ID if it's not set
    if not data.ID then
        data.ID = Notify.CurrentID
    end

    -- Set default duration if not set
    if not data.Duration then
        data.Duration = 3
    end

   data.StartTime = globals.RealTime()
    table.insert(Notify.Notifications, data)
    Notify.CurrentID = Notify.CurrentID + 1

    return data.ID
end

function Notify.Alert(title)
    Notify.Push({
        Title = title
    })
end

---@param title string
---@param msg string
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
        if globals.RealTime() - note.StartTime > note.Duration then
            Notify.Notifications[i] = nil
        else
            local deltaTime = globals.RealTime() - note.StartTime
            local durStep = deltaTime / note.Duration
            local fadeAlpha = math.floor(math.min(255, deltaTime * 4 * 255))

            -- Background
            draw.Color(35, 50, 60, fadeAlpha)
            draw.FilledRect(Offset.X, currentY, Offset.X + Size.W, currentY + Size.H)

            -- Duration indicator
            local barWidth = math.floor(Size.W * durStep)
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