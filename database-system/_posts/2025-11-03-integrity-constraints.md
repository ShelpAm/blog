---
title: Database Systems - Integrity Constraints on DB
---

## 符号定义

- `<CONSTRAINT>` (完整性约束命名子句): `NOT NULL`, `CHECK(<EXPR>)`
- `<PROPERTY>`: `<KEY> <TYPE> [CONSTRAINT <CONSTRAINT_NAME> <CONSTRAINT>]`

> 要修改 CONSTRAINT ，可先 DROP 后 ADD 。
{: .prompt-tip }

## Entity integrity (实体完整性)

## Referential integrity (参照完整性)

## User-defined integrity (用户定义的完整性)


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

