local symbol_list = require("ltt.symbol")

local function append(tokens, token)
    table.insert(tokens, token)
end

return function(input)
    local tokens = {}
    local index = 1

    while index <= #input do
        local char = input:sub(index, index)

        if char:match("%s") then
            index = index + 1
        elseif char == "(" then
            append(tokens, {
                type = "lparen",
                value = char
            })
            index = index + 1
        elseif char == ")" then
            append(tokens, {
                type = "rparen",
                value = char
            })
            index = index + 1
        else
            local rest = input:sub(index)
            local var = rest:match("^[_%a][_%w]*")
            local val = rest:match("^[01]")

            if val then
                append(tokens, {
                    type = "val",
                    value = val
                })
                index = index + #val
            elseif var and #var > 1 then
                append(tokens, {
                    type = "var",
                    value = var
                })
                index = index + #var
            else
                local symbol, alias = symbol_list.match_alias(input, index)

                if symbol then
                    append(tokens, {
                        type = "symbol",
                        value = symbol.id,
                        raw = alias
                    })
                    index = index + #alias
                elseif var then
                    append(tokens, {
                        type = "var",
                        value = var
                    })
                    index = index + #var
                else
                    error("无法识别的字符: " .. char, 0)
                end
            end
        end
    end

    return tokens
end
