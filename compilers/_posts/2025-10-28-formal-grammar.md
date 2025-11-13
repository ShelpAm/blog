---
title: Compilers - Formal Grammar
math: true
---

> 自顶向下
> - 的两个动作：匹配，推导（展开）。
> - 从开始符出发，推导出给定的串。

## Terminologies

- **导空**：$$X$$ 可导空意味着 $$X \Rightarrow^* \varepsilon$$。


## FIRST set

FIRST set (FIRST 集) 是由给定串能推导到的所有第一个终结符的集合。

### Derive the FIRST set according to its definition

1. 对于推导规则 $$S \to X_0 X_1 X_2 ... X_n$$，找到第一个不能导空的符号（记为 $$j$$），则令
   $$\text{FIRST}(S) := \text{FIRST}(X_0) \cup \text{FIRST}(X_1) \cup \dots \cup \{X_j\} - \{\varepsilon\}$$。
1. 若此串能推导为空，则集合加上 $$\varepsilon$$。


## FOLLOW set

FOLLOW set (FOLLOW 集)是由给定非终结符后可能出现的所有终结符的集合。

### Derive the FOLLOW set according to its definition

1. 对开始符 $$S$$，$$\text{FOLLOW}(S) := \{\#\}$$；对于其他符号（如 $$A$$），$$\text{FOLLOW}(A) := \{\}$$。
1. 要求 $$\text{FOLLOW}(E)$$，需找到所有 $$E$$ 在右边的推导规则，不妨记为 $$A \Rightarrow \alpha E \beta$$。
   则令 $$\text{FOLLOW}(E) := \text{FOLLOW}(E) \cup \text{FIRST}(\beta)$$。
   若 $$\beta \Rightarrow^* \varepsilon$$，则令 $$\text{FOLLOW}(E) := \text{FOLLOW}(E) \cup \text{FOLLOW}(A)$$。
1. 去掉集合中的 $$\varepsilon$$。

## SELECT set

SELECT set (SELECT 集) 描述了“应当在什么输入符号下选择某条产生式”。

即：若

$$
X \in \text{SELECT}(A \to \alpha),
$$

则当下一个符号输入为 $$X$$ 时，可选择产生式 $$A \to \alpha$$。


形式化地：

$$
\text{SELECT}(A \to \alpha) =
\begin{cases}
\text{FIRST}(\alpha), & \text{if } \varepsilon \notin \text{FIRST}(\alpha) \\[6pt]
(\text{FIRST}(\alpha) - \{\varepsilon\}) \cup \text{FOLLOW}(A), & \text{if } \varepsilon \in \text{FIRST}(\alpha)
\end{cases}
$$

## LL grammar

Definition: see <https://en.wikipedia.org/wiki/LL_grammar>.

对于 $$\text{LL}(k)$$ ：

- $$\text{LL}$$: From **L**eft to right, derive **L**eftmost word.
- $$k$$: 选择产生式时，需向前看 k 个字符。

## LL(1) grammar

特别地，对 $$\text{LL}(1)$$ 来说，对任意的非终结符 $$A$$，SELECT 集之间不能有交集。

### Determine whether a grammar is LL(1) and convert non-LL(1) to LL(1)

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

### 递归下降法

若 $$\text{SELECT}(A \to \beta)$$ 间无交集，则可用递归实现 `switch (symbol) { case beta[0]: case
beta[1]:  }`。

