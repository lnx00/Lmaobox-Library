local Gradient = { }

-- Creates gradients in the RGBA8888 format as RGBA binary data

-- [PERFORMANCE INTENSIVE] Creates a linear gradient (only 255 pixels or greater)
function Gradient.CreateLinear(start, _end, width, height)
    local start = start or { 0, 0, 0, 255 }
    local _end = _end or { 255, 255, 255, 255 }
    local width = width or 256
    local height = height or 256
    local data = ""
    local step = { }
    local stepX = (_end[1] - start[1]) / width
    local stepY = (_end[2] - start[2]) / height
    local stepZ = (_end[3] - start[3]) / width
    local stepW = (_end[4] - start[4]) / height
    for i = 0, width - 1 do
        step[1] = start[1] + i * stepX
        for j = 0, height - 1 do
            step[2] = start[2] + j * stepY
            step[3] = start[3] + i * stepZ
            step[4] = start[4] + j * stepW
            data = data .. string.char(step[1]) .. string.char(step[2]) .. string.char(step[3]) .. string.char(step[4])
        end
    end
    return data
end

return Gradient