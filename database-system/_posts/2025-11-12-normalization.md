---
title: Database System - Normalization
math: true
---

## Functional dependency

Definition, see [Functional Dependency]({% post_url database-system/_posts/2025-11-12-the-theory-of-relational-database %}#fd).

### Determine functional dependency

Functional dependency is dependent on semantics of data.

### Trivial and non-trivial functional dependency

Given that $X \to Y$,

If $Y \subseteq X$,

then we say $X \to Y$ is a trivial functional dependency.

Otherwise, it is non-trivial.

### 完全函数依赖与部分函数依赖

若任意 $X$ 的真子集 $X'$ 都不存在 $X' \to Y$，
则 $X \to Y$ 是完全函数依赖，
否则是部分函数依赖。

- 完全函数依赖记作：$X \xrightarrow{F} Y$
- 部分函数依赖记作：$X \xrightarrow{P} Y$

> 若 $X$ 为单属性，则一定为完全函数依赖，此时记为 $X \to Y$。
{: .prompt-tip }

--------问一下ppt里的，超码定义那里，“K的任意一个真子集都不是候选码”错了？


### Transitive functional dependency

If $X \to Y$ and $Y \to Z$, then $X \to Z$ is a transitive functional dependency.

## Key


## 范式

### 1NF

Requirements for 1NF:
- 所有属性均不可分，即不能表中套表。

1. 2NF
1. 3NF
1. BCNF
1. 4NF
