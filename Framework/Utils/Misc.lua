local Misc = { }

-- Sanitizes a given string
function Misc.Sanitize(str)
    str:gsub("\"", "'")
    str:gsub("\n", "")
    return str
end

return Misc