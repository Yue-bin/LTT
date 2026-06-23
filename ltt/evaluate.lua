local symbol_list = require("ltt.symbol")

local _M = {}

local function add_var(vars, seen, name)
    if not seen[name] then
        seen[name] = true
        table.insert(vars, name)
    end
end

local function walk_vars(ast, vars, seen)
    if not ast then
        return
    end

    if ast.token.type == "var" then
        add_var(vars, seen, ast.token.value)
    end

    walk_vars(ast.left, vars, seen)
    walk_vars(ast.right, vars, seen)
end

function _M.vars(ast)
    local vars = {}
    walk_vars(ast, vars, {})
    table.sort(vars)
    return vars
end

function _M.value(ast, env)
    local token = ast.token

    if token.type == "val" then
        return token.value == "1"
    end

    if token.type == "var" then
        if env[token.value] == nil then
            error("变元未赋值: " .. token.value, 0)
        end

        return env[token.value]
    end

    if token.type == "symbol" then
        local symbol = symbol_list.get(token.value)

        if not symbol then
            error("未知逻辑符号: " .. token.value, 0)
        end

        if symbol.arity == 1 then
            return symbol.opt(_M.value(ast.right, env))
        end

        if symbol.arity == 2 then
            return symbol.opt(_M.value(ast.left, env), _M.value(ast.right, env))
        end

        error("不支持的符号元数: " .. tostring(symbol.arity), 0)
    end

    error("不支持的节点类型: " .. tostring(token.type), 0)
end

function _M.rows(ast)
    local vars = _M.vars(ast)
    local rows = {}
    local count = 2 ^ #vars

    for mask = 0, count - 1 do
        local env = {}
        local values = {}

        for index, name in ipairs(vars) do
            local bit = (#vars - index)
            local value = math.floor(mask / (2 ^ bit)) % 2 == 1
            env[name] = value
            values[name] = value
        end

        table.insert(rows, {
            values = values,
            result = _M.value(ast, env)
        })
    end

    return vars, rows
end

return _M
