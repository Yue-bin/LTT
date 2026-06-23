-- 每个node包含：解析好的token，以及连接关系
-- 初值为nil
local node = {
    token = nil,
    left = nil,
    right = nil,
    father = nil -- 加上这个方便回溯
}
