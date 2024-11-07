--[[
    UI Notifications

    A notification can have the following attributes:
    Title, Content, Duration
]]

---@type Fonts
local fonts = require("src/UI/Fonts")

-- Style constants
local Size = { W = 300, H = 50 }
local Offset = { X = 10, Y = 10 }
local Padding = { X = 10, Y = 10 }
local FadeTime = 0.3

---@class Notify
local notify = {}

---@alias Notification { id: integer, duration: number?, start_time: number, title: string, msg: string }
---@type table<integer, Notification>
local notifications = {}
local currentID = 0

-- Advanced notification with custom data
---@param data Notification
---@return integer
function notify.push(data)
    assert(type(data) == "table", "Notify.Push: data must be a table")

    data.id = currentID
    data.duration = data.duration or 3
    data.start_time = globals.RealTime()

    notifications[data.id] = data
    currentID = (currentID + 1) % 1000

    return data.id
end

-- Simple notification with a title
---@param title string
---@param duration? number
---@return integer
function notify.alert(title, duration)
    return notify.push({
        title = title,
        duration = duration
    })
end

-- Simple notification with a title and a message
---@param title string
---@param msg string
---@param duration? number
---@return integer
function notify.simple(title, msg, duration)
    return notify.push({
        title = title,
        msg = msg,
        duration = duration
    })
end

-- Removes a notification by ID
---@param id number
function notify.pop(id)
    local notification = notifications[id]
    if notification then
        notification.duration = 0
    end
end

local function OnDraw()
    local currentY = Offset.Y

    for id, note in pairs(notifications) do
        local deltaTime = globals.RealTime() - note.start_time

        if deltaTime > note.duration then
            notifications[id] = nil
        else
            -- Fade transition
            local fadeStep = 1.0
            if deltaTime < FadeTime then
                fadeStep = deltaTime / FadeTime
            elseif deltaTime > note.duration - FadeTime then
                fadeStep = (note.duration - deltaTime) / FadeTime
            end

            local fadeAlpha = math.floor(fadeStep * 255)
            currentY = currentY - math.floor((1 - fadeStep) * Size.H)

            -- Background
            draw.Color(35, 50, 60, fadeAlpha)
            draw.FilledRect(Offset.X, currentY, Offset.X + Size.W, currentY + Size.H)

            -- Duration indicator
            local barWidth = math.floor(Size.W * (deltaTime / note.duration))
            draw.Color(255, 255, 255, 150)
            draw.FilledRect(Offset.X, currentY, Offset.X + barWidth, currentY + 5)

            draw.Color(245, 245, 245, fadeAlpha)

            -- Title Text
            draw.SetFont(fonts.SegoeTitle)
            if note.title then
                draw.Text(Offset.X + Padding.X, currentY + Padding.Y, note.title)
            end

            -- Content Text
            draw.SetFont(fonts.Segoe)
            if note.msg then
                draw.Text(Offset.X + Padding.X, currentY + Padding.Y + 20, note.msg)
            end

            currentY = currentY + Size.H + Offset.Y
        end
    end
end

Internal.RegisterCallback("Draw", OnDraw, "UI", "Notify")

return notify
