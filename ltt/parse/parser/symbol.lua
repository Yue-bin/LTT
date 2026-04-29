-- 递归匹配所有符号的别名
local symbol_list = require("ltt.symbol")

return function(input)
    for name, symbol in pairs(symbol_list) do
        for _, alias in ipairs(symbol.alias) do
            if input:match(alias) then
                return {
                    type = "symbol",
                    value = name
                }
            end
        end
    end
end
