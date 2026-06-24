local ltt = require("ltt.core")
local tokenizer = require("ltt.parse.tokenizer")

local function assert_equal(actual, expected, message)
    if actual ~= expected then
        error(string.format("%s: expected %s, got %s", message, tostring(expected), tostring(actual)), 0)
    end
end

local function assert_tokens(input, expected)
    local tokens = tokenizer(input)

    assert_equal(#tokens, #expected, "token count for " .. input)

    for index, token in ipairs(tokens) do
        assert_equal(token.type, expected[index].type, "token type " .. index)
        assert_equal(token.value, expected[index].value, "token value " .. index)
    end
end

assert_tokens("P <-> !Q", {
    { type = "var", value = "P" },
    { type = "symbol", value = "equ" },
    { type = "symbol", value = "neg" },
    { type = "var", value = "Q" },
})

assert_tokens("(foo_1 -> 0)", {
    { type = "lparen", value = "(" },
    { type = "var", value = "foo_1" },
    { type = "symbol", value = "imp" },
    { type = "val", value = "0" },
    { type = "rparen", value = ")" },
})

assert_tokens("fooVar", {
    { type = "var", value = "fooVar" },
})

assert_tokens("pV!q", {
    { type = "var", value = "p" },
    { type = "symbol", value = "dis" },
    { type = "symbol", value = "neg" },
    { type = "var", value = "q" },
})

assert_tokens("pVq", {
    { type = "var", value = "p" },
    { type = "symbol", value = "dis" },
    { type = "var", value = "q" },
})

local implication = ltt.truth_table("P -> Q")
assert_equal(#implication.vars, 2, "implication var count")
assert_equal(#implication.rows, 4, "implication row count")
assert_equal(implication.rows[1].result, true, "0 -> 0")
assert_equal(implication.rows[3].result, false, "1 -> 0")
assert_equal(implication.rows[4].result, true, "1 -> 1")

local right_associative = ltt.truth_table("P -> Q -> R")
assert_equal(right_associative.rows[5].result, true, "1 -> (0 -> 0)")

local equivalence = ltt.truth_table("P <-> Q")
assert_equal(equivalence.rows[1].result, true, "0 <-> 0")
assert_equal(equivalence.rows[2].result, false, "0 <-> 1")
assert_equal(equivalence.rows[4].result, true, "1 <-> 1")

local compact_disjunction = ltt.truth_table("(!p→q)→(pV!q)")
assert_equal(#compact_disjunction.vars, 2, "compact disjunction var count")
assert_equal(compact_disjunction.rows[2].result, false, "(!0 -> 1) -> (0 V !1)")

local ok, err = pcall(function()
    ltt.truth_table("P Q")
end)
assert_equal(ok, false, "invalid expression fails")
assert_equal(err, "无法解析多余内容: Q", "invalid expression error")

print("ok")
