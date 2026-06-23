-- 按注册顺序提供优先级
local registed = {
    "neg", -- 否定
    "con", -- 合取
    "dis", -- 析取
    "imp", -- 蕴含
    "equ", -- 等价
}

local symbol_list = {}
local by_id = {}
local aliases = {}

for _, symbol in ipairs(registed) do
    local item = require("ltt.symbol." .. symbol)
    table.insert(symbol_list, item)
    by_id[item.id] = item

    for _, alias in ipairs(item.alias) do
        table.insert(aliases, {
            value = alias,
            symbol = item
        })
    end
end

table.sort(aliases, function(left, right)
    return #left.value > #right.value
end)

function symbol_list.get(id)
    return by_id[id]
end

function symbol_list.aliases()
    return aliases
end

function symbol_list.match_alias(input, index)
    index = index or 1

    for _, alias in ipairs(aliases) do
        local value = alias.value
        if input:sub(index, index + #value - 1) == value then
            return alias.symbol, value
        end
    end
end

return symbol_list
