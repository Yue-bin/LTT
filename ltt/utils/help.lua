--- 输出各种帮助信息的模块
local _M = {}

function _M.symbol_help()
    local symbol_list = require("ltt.symbol")
    for _, symbol in ipairs(symbol_list) do
        print(string.format("Symbol: %s (%s)", symbol.name, symbol.id))
        print("Aliases:")
        print(table.concat(symbol.alias, ", "))
        print()
    end
end

return _M
