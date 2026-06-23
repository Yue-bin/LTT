local _M = {}

function _M.new(token, left, right)
    return {
        token = token,
        left = left,
        right = right
    }
end

return _M
