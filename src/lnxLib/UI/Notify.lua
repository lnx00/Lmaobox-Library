--[[
    UI Notifications

    A notification can have the following attributes:
    Title, Content, Duration
]]

---@type Fonts
local Fonts = require("lnxLib/UI/Fonts")

-- Style constants
local Size = { W = 300, H = 50 }
local Offset = { X = 10, Y = 10 }
local Padding = { X = 10, Y = 10 }
local FadeTime = 0.3

---@class Notify
local Notify = {}

---@alias Notification { ID : integer, Duration : number?, StartTime : number, Title : string, Content : string }
---@type table<integer, Notification>
local notifications = {}
local currentID = 0

-- Advanced notification with custom data
---@param data Notification
---@return integer
function Notify.Push(data)
    assert(type(data) == "table", "Notify.Push: data must be a table")

    data.ID = currentID
    data.Duration = data.Duration or 3
    data.StartTime = globals.RealTime()

    notifications[data.ID] = data
    currentID = (currentID + 1) % 1000

    return data.ID
end

-- Simple notification with a title
---@param title string
---@param duration? number
---@return integer
function Notify.Alert(title, duration)
    return Notify.Push({
        Title = title,
        Duration = duration
    })
end

-- Simple notification with a title and a message
---@param title string
---@param msg string
---@param duration? number
---@return integer
function Notify.Simple(title, msg, duration)
    return Notify.Push({
        Title = title,
        Content = msg,
        Duration = duration
    })
end

-- Removes a notification by ID
---@param id number
function Notify.Pop(id)
    local notification = notifications[id]
    if notification then
        notification.Duration = 0
    end
end

local function OnDraw()
    local currentY = Offset.Y

    for id, note in pairs(notifications) do
        local deltaTime = globals.RealTime() - note.StartTime

        if deltaTime > note.Duration then
            notifications[id] = nil
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

Internal.RegisterCallback("Draw", OnDraw, "UI", "Notify")

return Notify
