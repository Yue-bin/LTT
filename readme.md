# LTT

*LTT is for **L**ua **T**ruth **T**able*

~~才不是Linus Tech Tip呢~~

一个Lua真值表生成器，核心功能可以抽象为

`(Logic Exp) -> Truth Table`

## 用法

```sh
lua ltt.lua "P -> Q"
```

输出：

```text
P | Q | P -> Q
--+---+-------
0 | 0 | 1
0 | 1 | 1
1 | 0 | 0
1 | 1 | 1
```

查看支持的逻辑符号：

```sh
lua ltt.lua --symbols
```

## 支持的表达式

- 变元：`P`、`Q`、`foo_1`
- 常量：`0`、`1`
- 括号：`(P -> Q) & R`
- 否定：`!P`、`~P`、`¬P`
- 合取：`P & Q`、`P ∧ Q`
- 析取：`P | Q`、`P ∨ Q`
- 蕴含：`P -> Q`、`P → Q`
- 等价：`P <-> Q`、`P ↔ Q`

## 测试

```sh
lua test/run.lua
```
