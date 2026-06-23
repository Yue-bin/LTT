-- 0,1视为常量
local reg = "[01]"

return function(input)
    local value = input:match(reg)

    if value then
        return {
            type = "val",
            value = value
        }
    end
end
