--- 内部统一命名映射到外部符号列表
--- @alias Symbol "con" | "dis" | "neg" | "imp" | "equ"
--- @type { [Symbol]: [string] }
local symbol_list = {
    -- 合取
    ["con"] = {
        "∧", "&", "^"
    },
    -- 析取
    ["dis"] = {
        "∨", "|", "v"
    },
    -- 非
    ["neg"] = {
        "¬", "~", "!"
    },
    -- 蕴含
    ["imp"] = {
        "→", "->", ">"
    },
    -- 等价
    ["equ"] = {
        "⇔", "↔", "<->", "="
    },
}

return symbol_list
