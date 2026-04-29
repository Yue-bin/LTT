local registed = {
    "con", -- 合取
    "dis", -- 析取
}

local symbol_list = {}

for _, symbol in ipairs(registed) do
    symbol_list[symbol] = require("ltt.symbol." .. symbol)
end

return symbol_list
