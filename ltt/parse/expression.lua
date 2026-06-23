local node = require("ltt.parse.tree.node")
local symbol_list = require("ltt.symbol")

local parser = {}
parser.__index = parser

local function token_name(token)
    if not token then
        return "表达式末尾"
    end

    return token.raw or token.value or token.type
end

local function parse_error(message)
    error(message, 0)
end

function parser.new(tokens)
    return setmetatable({
        tokens = tokens,
        index = 1
    }, parser)
end

function parser:peek()
    return self.tokens[self.index]
end

function parser:advance()
    local token = self:peek()
    self.index = self.index + 1
    return token
end

function parser:parse_prefix()
    local token = self:advance()

    if not token then
        parse_error("缺少表达式")
    end

    if token.type == "var" or token.type == "val" then
        return node.new(token)
    end

    if token.type == "lparen" then
        local expr = self:parse_expression(0)
        local close = self:advance()

        if not close or close.type ~= "rparen" then
            parse_error("缺少右括号")
        end

        return expr
    end

    if token.type == "symbol" then
        local symbol = symbol_list.get(token.value)

        if symbol and symbol.arity == 1 then
            return node.new(token, nil, self:parse_expression(symbol.precedence))
        end
    end

    parse_error("不能以 " .. token_name(token) .. " 开始表达式")
end

function parser:parse_expression(min_precedence)
    local left = self:parse_prefix()

    while true do
        local token = self:peek()

        if not token or token.type ~= "symbol" then
            break
        end

        local symbol = symbol_list.get(token.value)

        if not symbol or symbol.arity ~= 2 then
            break
        end

        if symbol.precedence < min_precedence then
            break
        end

        self:advance()

        local next_min = symbol.precedence + 1
        if symbol.associativity == "right" then
            next_min = symbol.precedence
        end

        local right = self:parse_expression(next_min)
        left = node.new(token, left, right)
    end

    return left
end

return function(tokens)
    local state = parser.new(tokens)
    local ast = state:parse_expression(0)
    local extra = state:peek()

    if extra then
        parse_error("无法解析多余内容: " .. token_name(extra))
    end

    return ast
end
