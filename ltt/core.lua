local tokenizer = require("ltt.parse.tokenizer")
local parse_expression = require("ltt.parse.expression")
local evaluate = require("ltt.evaluate")

local _M = {}

function _M.parse(input)
    return parse_expression(tokenizer(input))
end

function _M.truth_table(input)
    local ast = _M.parse(input)
    local vars, rows = evaluate.rows(ast)

    return {
        expression = input,
        ast = ast,
        vars = vars,
        rows = rows
    }
end

return _M
