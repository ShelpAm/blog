---
title: Compilers - LR Parsing
math: true
---

$\text{LR}(k)$ parsing is a bottom-up grammar parsing method, for which:
- $\text{LR}$ stands for "Read from **L**eft to Right, Derive **R**ightmost Word".
- $k$ stands for the number of character to lookahead.

## Terminology

- Canonical sentential form (规范句型): sentences derived by rightmost derivation.
- Canonical reduction (规范规约): left most reduction.
- Canonical prefix (规范前缀): given canonical sentential form $\alpha \eita$, where $\eita$ is
  non-terminant or $\varepsilon$, then $\alpha$ is canonical prefix.
- Canonical viable prefix (规范活前缀): $\alpha$ has form $\alpha' \pi$, where $\pi$ is a handle or $$.
  - 移入型规范活前缀: $\alpha$ 不含句柄
  - 规约型规范活前缀: $\alpha$ 含一个句柄

## LR(0) parsing

In bottom-up approach, we have two actions - shift (移入), and reduce (规约).

The **crux**: when to perform which.

LR parsing provides two tables (Action and Goto) to clarify this.

### Constructing LR automaton

#### Terminology
- LR item: dotted production, to represent the process of reduction.
  - shift item: 形如 $S \to \cdot \alpha$
  - reducible item: 形如 $S \to \pi \cdot$，且不是拓广表达式。

- Accepting state: 包含拓广表达式 $S' \to S \cdot$ 的状态。

- $\text{closure}(IS)$ is all LR items that can be inferred by LR item set $IS$.
  1. $IS \in \text{closure}(IS)$
  2. $\text{If } B \to \alpha \cdot A \beta \text{ and } A \to \pi, \text{ then add } A \to \cdot \pi \text{ to closure}(IS)$

- $\text{project}(IS, X) = \lbrace A \to \alpha \cdot X \beta \mid A \to \alpha \cdot X \beta \in IS \rbrace$
  - 获取下一个符号为 $X$ 的子集。(X 可以为终结符)

- $\text{shift}(IS, X) = \lbrace A \to \alpha X \cdot \beta \mid A \to \alpha \cdot X \beta \in IS \rbrace$
  - 将所有 $IS$ 中下一个符号为 $X$ 的 LR 项目里的 $\cdot$ 都向右移一步。

- $\text{goto}(IS, X) = \text{closure}(\text{shift}(\text{project}(IS, X), X))$
  > 这里project实际上是重复的，因为shift已经有过滤X了；此处加上只是为了显示地表达需要过滤。

#### Building the automaton graph
1. Initially append an ending tag (#) to _start production_ (noted as $S' \to S \\#$).
2. Initial state is $closure(\lbrace S' \to \cdot S \\# \rbrace)$.
3. For every availale $NextState = goto(CurrentState, X_i)$, add an edge $CurrentState \xrightarrow{X_i} NextState$.
4. Repeat step 3 until no any new state, where "$\cdot$" always reaches the end.

> $\varepsilon$ shouldn't be regarded as a symbol, but be ignored.
{: .prompt-warning }

若某状态包含以下某种冲突，则此文法不是 LR(0) 文法：
- reduce - reduce conflict
- shift - reduce  conflict

### Constructing LR parse tables

Before constructing LR parse tables, we should first [construct LR automaton](#constructing-lr-automaton).

#### Action/Goto table example

Here is an example action/goto table:

| State | Action      |      |      | Goto |      |
|-------|-------------|------|------|------|------|
|       | _id_        | _+_  | _#_  | _E_  | _T_  |
| 0     | s5          |      |      | 1    | 2    |
| 1     |             | s6   | acc  |      |      |
| 2     | r2          | r2   | r2   |      |      |

, where action table only contains terminals while goto table only contains non-terminals.

#### Definition

$$
\begin{align}
  Action(S_i, X) &=
  \begin{cases}
  s_j, & \text{if there is an edge } S_i \xrightarrow{X} S_j, \\
  r_j, & \text{if } S_i \text{ contains only reducible } Production_j, \\
  Accept, & \text{if } S_i \text{ is an accepting state}.
  \end{cases}
\\
  Goto(S_i, X) &= j, \quad \text{ if there is an edge } S_i \xrightarrow{X} S_j
\end{align}
$$

### Using LR parsing tables

使用 LR(0) 驱动器算法：

![LR(0) 驱动器算法](/assets/images/lr0-driver-algo.png)
_LR(0) 驱动器算法_


## SLR(1) parsing

LR(0) 分析限制过大，而 SLR(1) 分析减少了 Action 表中的规约列，进而减少冲突，更易满足条件。

相较 LR(0) 分析，对 LR 项目 $X \to \pi \cdot$ 来说，规约列只有 $FOLLOW(X)$。因此，只要所有规约项目 (reducible
item) 的 FOLLOW 集及移入项目 (shift item) 两两之间无冲突，文法就是 SLR(1) 文法。

## LR(1) parsing

## LALR(1)
