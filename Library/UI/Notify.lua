--[[
    UI Notifications

    A notification can have the following attributes:
    Title, Content, Duration
]]

---@type Globals
local Globals = require(LIB_PATH .. "TF2/Globals")

---@class Notify
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
        data.Duration = 5
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
    local lastY = 10

    for i, note in pairs(Notify.Notifications) do
        if globals.RealTime() - note.StartTime > note.Duration then
            Notify.Notifications[i] = nil
        else
            -- Background
            draw.Color(25, 25, 35, 250)
            draw.FilledRect(10, lastY, 10 + 250, lastY + 60)
            draw.Color(255, 255, 255, 255)

            -- Duration indicator
            local duration = note.Duration - (globals.RealTime() - note.StartTime)
            local barWidth = math.floor(250 * (duration / note.Duration))
            draw.Color(255, 255, 255, 100)
            draw.FilledRect(10, lastY, 10 + barWidth, lastY + 5)

            draw.Color(245, 245, 245, 255)
            draw.SetFont(Globals.TitleFont)
            if note.Title then
                draw.Text(20, lastY + 10, note.Title)
            end

            draw.SetFont(Globals.DefaultFont)
            if note.Content then
                draw.Text(20, lastY + 35, note.Content)
            end

            lastY = lastY + 70
        end
    end
end

return Notify