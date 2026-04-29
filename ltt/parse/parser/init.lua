-- 按注册顺序匹配
local registed = {
    "symbol", -- 符号"
    "var",    -- 变元"
    "val"     -- 常量"
}

local parser_list = {}

for _, parser_name in ipairs(registed) do
    table.insert(parser_list, require("ltt.parse.parser." .. parser_name))
end

return function(input)
    for _, parser in ipairs(parser_list) do
        local result = parser(input)
        if result then
            return result
        end
    end
end
