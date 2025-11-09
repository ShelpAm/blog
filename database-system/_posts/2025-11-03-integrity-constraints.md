---
title: Database System - Integrity Constraints on DB
---

关系的两个不变性：[实体完整性](#entity-integrity-实体完整性)和[参照完整性](#referential-integrity-参照完整性)。

## 符号定义

- `<CONSTRAINT>` (完整性约束命名子句): `NOT NULL`, `CHECK(<EXPR>)`
- `<PROPERTY>`: `<KEY> <TYPE> [CONSTRAINT <CONSTRAINT_NAME> <CONSTRAINT>]`

> 要修改 CONSTRAINT ，可先 DROP 后 ADD 。
{: .prompt-tip }

> Don't forget to add `,` to seperate different table-level constraints.
{: .prompt-tip }

## Entity integrity (实体完整性)

主码非空且唯一。

### Define entity integrity constraints

Add the following to table-level constraints:
```sql
PRIMARY KEY(<KEY> [, <KEY1>, <KEY2>, ...])
```

## Referential integrity (参照完整性)

外码值必需满足以下条件其一：
- 为空
- 存在于被参照关系的主码中

这是为了防止产生 dangling pointer。

### Define referential integrity constraints

Add the following to table-level constraints:
```sql
FOREIGN KEY <KEY> REFERENCING <REFERENCED_TABLE>(<FOREIGN_KEY>)
```

## User-defined integrity (用户定义的完整性)

## Define constraints on a database

### 元组上的约束

格式：
```sql
CREATE TABLE <TABLE_NAME> (
    <PROPERTY> [, <PROPERTY1>, <PROPERTY2>, ...]
    [<CONSTRAINT>]
);
```

## Trigger

Trigger (触发器) 在 UPDATE, DELETE, INSERT (不包含 SELECT) 时自动执行一些
_可自定义的_脚本。触发器只能定义在基本表中，而不能定义在 view (视图) 上。

### Define a trigger

```sql
CREATE TRIGGER <TRIGGER>
AFTER|BEFORE <OPERATION> ON <TABLE>
[REFERENCING [NEW AS <NAME1>] [OLD AS <NAME2>]]
FOR EACH ROW
BEGIN
    <YOUR_FUNCTION>
END
```

### Drop a trigger

```sql
DROP TRIGGER <TRIGGER> ON <TABLE>
```

