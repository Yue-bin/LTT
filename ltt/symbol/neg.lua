local _M = {
    id = "neg",
    name = "否定",
    alias = {
        "¬", "~", "!", "￢"
    },
    arity = 1,
    precedence = 5,
    associativity = "right",
    param = {
        "right"
    }
}

function _M.opt(value)
    return not value
end

return _M
