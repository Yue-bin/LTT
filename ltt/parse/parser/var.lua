-- 字母视为变元
local reg = "%a"

return function(input)
    local value = input:match(reg)

    if value then
        return {
            type = "var",
            value = value
        }
    end
end
