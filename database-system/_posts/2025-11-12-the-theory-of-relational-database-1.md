---
title: Database System - The Theory of Relational Database (1)
math: true
---

## Possible problems in bad designs

- **Data redundancy**: 冗余数据。

- **Update anomaly**: 更新时会涉及很多数据的更新，以防止数据不一致。

- **Insertion anomaly**: TODO 插入时无法插入（？）

- **Deletion anomaly**: 删去时，将某些有用数据删去。

A good design usually doesn't have above problems, but there are **exceptions**:
- When performance is critical and data repeatness are less taken into account.


## Data dependency

- 数据库模式设计的关键。

### Types of data dependency

- **Functional dependency** (FD, 函数依赖)<a id="fd"></a>: Given a function $y = f(x)$, we say that $y$ is
  functional dependent on $x$. Noted as $X \to Y$

- **Multivalued dependency** (MVD, 多值依赖): Given a relation $R(A, B, C)$, if it satisfies $A \to B$
  and $A \to C$ , we say this is a MVD.

- **Transitive dependency**: If $A \to B$ and $B \to C$, then $A \to C$ is a transitive denpendency.


## Functional dependency

Definition, see [Functional Dependency](#fd).

### Determining functional dependency

Functional dependency is dependent on semantics of data.

### Trivial and non-trivial functional dependency
> 平凡/非平凡函数依赖

Given that $X \to Y$,

If $Y \subseteq X$,

then we say $X \to Y$ is a trivial functional dependency.

Otherwise, it is non-trivial.

### Full and partial functional dependency
> 完全/部分函数依赖

若任意 $X$ 的真子集 $X'$ 都不存在 $X' \to Y$，
则 $X \to Y$ 是完全函数依赖，
否则是部分函数依赖。

- 完全函数依赖记作：$X \xrightarrow{F} Y$
- 部分函数依赖记作：$X \xrightarrow{P} Y$

> 若 $X$ 为单属性，则一定为完全函数依赖，此时记为 $X \to Y$。
{: .prompt-tip }

## Closure
> 闭包

Closure $F^+$ of set $F$ contains all the relations that can be inferred by FD.

## Canonical cover
> 规范覆盖, 最小覆盖

A canonical cover $F_c$ for $F$ is a set of dependencies such that
- it contains no extraneous functional dependency.
- every lhs is unique.

### Computing the canonical cover

Here is an algorithm to compute canonical cover: (Teached by my teacher in school)

1. $F_c := F$
2. Decompose each dependency $\alpha \to \beta$ in $F_c$ into
   $\alpha \to \beta_1, \alpha \to \beta_2, \dots, \alpha \to \beta_n$.
3. For each dependency, [test](#testing-for-extraneous-dependency) if it's
   extraneous. If it is, then remove it from $F_c$.
4. For each dependency $\alpha \to \beta$, if $F_c$ contains any $\alpha_i \to \alpha_j$, remove
   $\alpha_j$ from $\alpha$.
5. Merge all functional dependencies that have the same left-hand side.

#### Testing for extraneous dependency 

To test a dependency denoted as $\alpha \to \beta$, if $F' = F - {\alpha \to \beta}$ is equivalent to $F$, then it's extraneous. Otherwise, it's not extraneous.

### Computing the candidate key

1. Initialize candidate key set $C$.
1. Find all attributes that doesn't appear in right-hand side, put them into $C$.
1. ~~瞪眼法！~~

## Decomposition

$R$ decomposed into $R_1, R_2, \dots, R_n$ can be denoted as $\rho(R_1, R_2, \dots, R_n)$.

### Lossless decomposition

Given $R = \rho(R_1, R_2, \dots, R_n)$, if $R_1 \Join R_2 \Join \dots \Join R_n = R$,
then it's a lossless decomposition.

### Dependency preservation

Given $R = \rho(R_1, R_2, \dots, R_n)$, if all $\alpha \to \beta$ co-exist in some $R_i$,
then that decomposition has dependency preservation.
