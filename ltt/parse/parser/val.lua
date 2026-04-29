-- 0,1视为常量
local reg = "[01]"

return function(input)
    return {
        type = "val",
        value = input:match(reg)
    }
end
