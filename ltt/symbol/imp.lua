local _M = {
    id = "imp",
    name = "蕴含",
    alias = {
        "→", "->", ">"
    },
    arity = 2,
    precedence = 2,
    associativity = "right",
    param = {
        "left", "right"
    }
}

function _M.opt(left, right)
    return (not left) or right
end

return _M
