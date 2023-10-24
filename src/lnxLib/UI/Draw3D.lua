---@class Draw3D
local Draw3D = {}

---@param min Vector3
---@param max Vector3
function Draw3D.Box(min, max)
    -- Vertices
    local vertices = {
        Vector3(min.x, min.y, min.z),
        Vector3(min.x, max.y, min.z),
        Vector3(max.x, max.y, min.z),
        Vector3(max.x, min.y, min.z),
        Vector3(min.x, min.y, max.z),
        Vector3(min.x, max.y, max.z),
        Vector3(max.x, max.y, max.z),
        Vector3(max.x, min.y, max.z)
    }

    -- Transform
    local screen = {}
    for i = 1, #vertices do
        screen[i] = client.WorldToScreen(vertices[i])
    end

    -- Draw
    for j = 1, 4 do
        local v1, v2 = screen[j], screen[j + 4]
        local v3, v4 = screen[j], screen[j % 4 + 1]
        local v5, v6 = screen[j + 4], screen[(j + 4) % 4 + 5]

        if v1 and v2 then draw.Line(v1[1], v1[2], v2[1], v2[2]) end
        if v3 and v4 then draw.Line(v3[1], v3[2], v4[1], v4[2]) end
        if v5 and v6 then draw.Line(v5[1], v5[2], v6[1], v6[2]) end
    end
end

function Draw3D.Line(start, finish)
    start = client.WorldToScreen(start)
    finish = client.WorldToScreen(finish)

    if start and finish then
        draw.Line(start[1], start[2], finish[1], finish[2])
    end
end

return Draw3D
