-- 按注册顺序提供优先级
local registed = {
    "con", -- 合取
    "dis", -- 析取
}

local symbol_list = {}

for _, symbol in ipairs(registed) do
    table.insert(symbol_list, require("ltt.symbol." .. symbol))
end

return symbol_list
