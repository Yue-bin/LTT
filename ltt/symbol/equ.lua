local _M = {
    id = "equ",
    name = "等价",
    alias = {
        "⇔", "↔", "<->", "="
    },
    arity = 2,
    precedence = 1,
    associativity = "left",
    param = {
        "left", "right"
    }
}

function _M.opt(left, right)
    return left == right
end

return _M
