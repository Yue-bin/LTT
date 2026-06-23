-- 返回一个迭代器，每次迭代返回一个token
-- 目前的实现是一个char一个token，缺点是不支持多字符变元和非ascii字符，优点是简单

return function(input)
    return string.gmatch(input, ".")
end
