local _M = {
    id = "dis",
    name = "析取",
    alias = {
        "∨", "|", "V", "v", "+"
    },
    arity = 2,
    precedence = 3,
    associativity = "left",
    param = {
        "left", "right"
    }
}

function _M.opt(left, right)
    return left or right
end

return _M
