---
title: Database System - The Theory of Relational Database (2)
math: true
---

## Introduction

- Normalization is a process to strip redundancies in relations.
- Key
  - 候选码：可以标识元组的最小属性集
  - 主码：指定的某个候选码
  - 码/超码：可以标识元组的属性集


## Normal Form (NF, 范式)

NF is of functional dependency on a relation.

 And you should simplify the relation into its canonical cover
to determine which NF the relation is in.

If we denote each dependency as $\alpha \to \beta$ (decompose $\beta$ into
$\alpha \to \beta_1, \alpha \to \beta_2, \dots, \alpha \to \beta_n$), then the following holds:

- 1NF: Atomic attributes and unique rows.
- 2NF: $\beta_i$ is prime attribute **or** $\alpha$ is NOT a proper subset of any candidate key. (No partial dependency on a candidate key.)
- 3NF: $\beta_i$ is prime attribute **or** $\alpha$ is a superkey. (No transitive dependency on a candidate key.)
- BCNF: $\alpha$ is a superkey.
- 4NF: No MVD.

, where each NF is based on lower level NFs.

> 软件开发中通常要达到3NF。
{:.prompt-info}

### BCNF (Boyce Codd Normal Form, aka 修正第三范式)

- Decomposite the relation into $\alpha \cup \beta$ and $R - (\beta - \alpha)$ to achieve BCNF.

> Drawback of BCNF:
>
> BCNF doesn't have dependency preservation.
>
{: .prompt-warning }

