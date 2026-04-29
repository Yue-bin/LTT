local _M = {
    id = "con",
    name = "合取",
    alias = {
        "∧", "&", "^", "*"
    },
    param = {
        "left", "right"
    }
}

function _M.opt(left, right)
    return left and right
end

return _M
