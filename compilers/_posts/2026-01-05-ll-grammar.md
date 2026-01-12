---
title: Compilers - LL Grammar
math: true
---

LL grammar is a kind of top down grammar (自顶向下文法).

> 自顶向下
> - 的两个动作：匹配，推导（展开）。
> - 从开始符出发，推导出给定的串。

## LL grammar

Definition: see <https://en.wikipedia.org/wiki/LL_grammar>.

对于 $$\text{LL}(k)$$ ：

- $$\text{LL}$$: From **L**eft to right, derive **L**eftmost word.
- $$k$$: 选择产生式时，需向前看 k 个字符。

## LL(1) grammar

### Determining whether a grammar is LL(1)

对 $$\text{LL}(1)$$ 来说，对任意的非终结符 $$A$$，SELECT 集之间不能有交集。

### Converting non-LL(1) to LL(1)

以下步骤均为 $$\text{LL}(1)$$ 型文法的必要条件，而非充分条件。

#### 提取左公共因子

给定

$$
A \to \alpha \beta \mid \alpha \gamma,
$$

其中右边有公共左前缀，则将其提取出来：

$$
\begin{align}
A &\to \alpha A' \\
A' &\to \beta \mid \gamma \\
\end{align}
$$

为防止隐含/间接公共左因子，需展开产生式。具体方法见：[处理隐含因子](#隐含间接-公共左因子左递归)。

#### 消除左递归

- 左递归形式： $$A \to A \alpha \mid \beta$$
- 右递归形式：$$A \to \alpha A \mid \beta$$
- 递归形式（既不算左递归也不算右递归）：$$A \to \alpha A \beta \mid \gamma$$

找到所有左递归，并将其转化为右递归：

$$
\begin{align}
A &\to \beta A' \\
A' &\to \varepsilon \mid \alpha A' \\
\end{align}
$$

> 若产生式不是标准左递归形式，但存在隐式左递归，应首先将其转化为标准形式。
{: .prompt-tip }

为防止隐含/间接左递归，需展开产生式。具体方法见：[处理隐含因子](#隐含间接-公共左因子左递归)。

#### 隐含/间接 公共左因子/左递归
<a name="隐含/间接 公共左因子/左递归"></a>
复杂情况下，需要规定非终结符的代入顺序，且必须全部代入。

### LL(1) 分析表

将 SELECT 集转化为 LL(1) 分析表，即一个从产生式左边到文本串开头符号的映射。

形如：

|Current\\Next|a|b|c|
|-|-|-|-|
|X|$$X\to\beta$$|...||
|Y|...|||
|Z||||

示例 C++ 实现，见 [GitHub compilers-labs](https://github.com/ShelpAm/compilers-labs/blob/1ec8596f88359a8ac5824bf21f1de7a7ae6e80dc/grammar.cpp#L285)：
```cpp
bool Grammar::match(Symbol_string s) const
{
    assert(std::ranges::all_of(
        s, [this](auto const &s) { return terminals_.contains(s); }));

    s.push_back(eol);
    Symbol_string t{eol, begin_}; // Acts as a stack
    auto ll1t = ll1_parse_table();
    while (!t.empty()) {
        // std::println("t={}  {}=s", t, s);
        if (terminals_.contains(t.back()) || t.back() == eol) {
            if (t.back() != s.front()) {
                // std::println("Terminal doesn't match, failed to match");
                return false;
            }
            t.pop_back();
            s.pop_front();
            continue;
        }
        auto jt = ll1t[t.back()].find(s.front());
        if (jt == ll1t[t.back()].end()) {
            // std::println("No item to match, failed to match");
            return false;
        }
        auto const &prod = jt->second;
        // std::println("Using production {}", prod);
        assert(prod.from == t.back());
        t.pop_back();
        if (!is_epsilon(prod.to))
            t.insert_range(t.end(), prod.to | std::views::reverse);
    }
    // No need to check eol because t won't contain eol. TODO: maybe this should
    // be checked?
    // std::println("All symbols in t matched, matching ok");
    return true;
}
```

### 递归下降法

若是 LL 文法，则可用递归实现 `switch (symbol) { case beta[0]: case beta[1]:  }`。

一个奇怪的 C++ 实现，见 [GitHub compilers-labs](https://github.com/ShelpAm/compilers-labs/blob/2a1a1dbe0ad78243959e73878478b85c65df42d6/grammar.cpp#L373)。

