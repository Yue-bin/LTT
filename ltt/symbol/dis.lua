local _M = {
    id = "dis",
    name = "析取",
    alias = {
        "∨", "|", "v", "+"
    },
    param = {
        "left", "right"
    }
}

function _M.opt(left, right)
    return left or right
end

return _M
