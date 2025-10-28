---
math: true
---

## FIRST set

FIRST set (FIRST 集) 是由给定串能推导到的所有第一个终结符的集合。

### Derive the FIRST set according to its definition

1. 对于推导规则 $$S \to X_0 X_1 X_2 ... X_n$$ ，找到第一个不能导空的符号（记为 $$j$$ ），则令
   $$\text{FIRST}(S) := \text{FIRST}(X_0) \cup \text{FIRST}(X_1) \cup \dots \cup \{X_j\}$$ 。
1. 若此串能推导为空，则集合加上 $$\varepsilon$$ 。


## FOLLOW set

FOLLOW set (FOLLOW 集)是由给定串后可能出现的所有终结符的集合。

### Derive the FOLLOW set according to its definition

1. 对开始符 $$S$$ ， $$\text{FOLLOW}(S) := \{\#\}$$ ；对于其他符号（如 $$A$$ ），$$\text{FOLLOW}(A) := \{\}$$。
1. 要求 $$\text{FOLLOW}(E)$$ ，需找到所有 $$E$$ 在右边的推导规则，不妨记为 $$A \Rightarrow \alpha E \beta$$ 。
   则令 $$\text{FOLLOW}(E) := \text{FOLLOW}(E) \cup \text{FIRST}(\beta)$$ 。
   若 $$\beta \Rightarrow^* \varepsilon$$，则令 $$\text{FOLLOW}(E) := \text{FOLLOW}(E) \cup \text{FOLLOW}(A)$$ 。
1. 去掉集合中的 $$\varepsilon$$ 。

## SELECT set

SELECT set (SELECT 集) 描述了“应当在什么输入符号下选择某条产生式”。

即：若

$$
X \in \text{SELECT}(A \to \alpha),
$$

则当下一个符号输入为 $$X$$ 时，应选择产生式 $$A \to \alpha$$ 。


形式化地：

$$
\text{SELECT}(A \to \alpha) =
\begin{cases}
\text{FIRST}(\alpha), & \text{if } \varepsilon \notin \text{FIRST}(\alpha) \\[6pt]
(\text{FIRST}(\alpha) - \{\varepsilon\}) \cup \text{FOLLOW}(A), & \text{if } \varepsilon \in \text{FIRST}(\alpha)
\end{cases}
$$