-- 字母视为变元
local reg = "%a"

return function(input)
    return {
        type = "var",
        value = input:match(reg)
    }
end
