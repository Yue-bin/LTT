local _M = {
    id = "con",
    name = "合取",
    alias = {
        "∧", "&", "^", "*"
    },
    arity = 2,
    precedence = 4,
    associativity = "left",
    param = {
        "left", "right"
    }
}

function _M.opt(left, right)
    return left and right
end

return _M
