local symbol_list = require("ltt.symbol")

local function append(tokens, token)
    table.insert(tokens, token)
end

local function starts_expression(input, index)
    if index > #input then
        return false
    end

    local char = input:sub(index, index)

    if char:match("%s") or char == "(" or char:match("[_%a01]") then
        return true
    end

    local symbol = symbol_list.match_alias(input, index)
    return symbol and symbol.arity == 1
end

local function compact_disjunction(input, index, var)
    if #var < 2 or var:sub(2, 2) ~= "V" then
        return
    end

    local rest = var:sub(3)
    if #rest == 1 or (#rest == 0 and starts_expression(input, index + #var)) then
        return 2
    end
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
                local symbol_offset = compact_disjunction(input, index, var)

                if symbol_offset then
                    local symbol, alias = symbol_list.match_alias(input, index + symbol_offset - 1)

                    append(tokens, {
                        type = "var",
                        value = var:sub(1, symbol_offset - 1)
                    })
                    append(tokens, {
                        type = "symbol",
                        value = symbol.id,
                        raw = alias
                    })
                    index = index + symbol_offset
                else
                    append(tokens, {
                        type = "var",
                        value = var
                    })
                    index = index + #var
                end
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
