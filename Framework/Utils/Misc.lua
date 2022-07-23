local Misc = { }

-- Sanitizes a given string
function Misc.Sanitize(str)
    str:gsub("%s", "")
    str:gsub("%%", "%%%%")
    return str
end

return Misc