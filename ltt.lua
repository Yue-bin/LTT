#!/usr/bin/env lua

--- 配置输入输出函数
-- Input = io.stdin
function Output(...)
    io.write(...)
end

local ltt = require("ltt.core")
local help = require("ltt.utils.help")

local function bool_text(value)
    if value then
        return "1"
    end

    return "0"
end

local function print_usage()
    Output("Usage:\n")
    Output("  lua ltt.lua \"P -> Q\"\n")
    Output("  lua ltt.lua --symbols\n")
    Output("  lua ltt.lua --help\n")
end

local function print_table(result)
    local headers = {}

    for _, name in ipairs(result.vars) do
        table.insert(headers, name)
    end

    table.insert(headers, result.expression)
    Output(table.concat(headers, " | "), "\n")

    local separators = {}
    for _, header in ipairs(headers) do
        table.insert(separators, string.rep("-", #header))
    end
    Output(table.concat(separators, "-+-"), "\n")

    for _, row in ipairs(result.rows) do
        local values = {}

        for _, name in ipairs(result.vars) do
            table.insert(values, bool_text(row.values[name]))
        end

        table.insert(values, bool_text(row.result))
        Output(table.concat(values, " | "), "\n")
    end
end

local args = {...}
local command = args[1]

if not command or command == "--help" or command == "-h" then
    print_usage()
    os.exit(command and 0 or 1)
end

if command == "--symbols" then
    help.symbol_help()
    os.exit(0)
end

local input = table.concat(args, " ")
local ok, result = pcall(ltt.truth_table, input)

if not ok then
    io.stderr:write("Error: ", result, "\n")
    os.exit(1)
end

print_table(result)
