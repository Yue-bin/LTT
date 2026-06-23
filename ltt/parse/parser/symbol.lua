-- 递归匹配所有符号的别名
local symbol_list = require("ltt.symbol")

return function(input)
    for _, symbol in ipairs(symbol_list) do
        for _, alias in ipairs(symbol.alias) do
            if input == alias then
                return {
                    type = "symbol",
                    value = symbol.id
                }
            end
        end
    end
end
