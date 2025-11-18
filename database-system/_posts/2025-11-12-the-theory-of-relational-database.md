---
title: Database System - The Theory of Relational Database
---

> Think about this: What is good design of a database?

## Possible problems in bad designs

- **Data redundancy**: 冗余数据。

- **Update anomaly**: 更新时会涉及很多数据的更新，以防止数据不一致。

- **Insertion anomaly**: TODO 插入时无法插入（？）

- **Deletion anomaly**: 删去时，将某些有用数据删去。

## (Functional) Dependency


## Data dependency

- 数据库模式设计的关键。

### Types of data dependency

- **Functional dependency** (函数依赖)<a id="fd"></a>: Given a function `f`, if, with certain `x`, `f(x)` is uniquely
  determined, then we say that `f` is dependent on `x`.

- **Multivalued dependency** (多值依赖)

- **传递依赖**

## Normalization

See [Normalization]({% post_url database-system/_posts/2025-11-12-normalization %}).
