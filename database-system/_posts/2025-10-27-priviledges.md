## Grant priviledges

### Syntax

```sql
GRANT <OPERATION>
ON <TABLE>
TO <USER> [<USER1> <USER2> ...]
[WITH GRANT OPTION];
```

- `<USER>` 可为 `PUBLIC`，意为所有人。注意：使用 `PUBLIC` 授予权限，意味着未来创建的用户仍然拥有此权限。
  （实际上 PUBLIC 的实现方式为标记某 `<OPERATION>` 的 `PUBLIC` 权限为真，因此 `PUBLIC` 为真时，所有用户均具有其权限。
  因此，先授予PUBLIC权限，再撤销某用户的权限，此用户仍具有此权限）
- `WITH GRANT OPTION` 允许被授权的用户传播其权力。


## Revoke priviledges

### Syntax

```sql
REVOKE <OPERATION>
ON <TABLE>
FROM <USER> [<USER1> <USER2> ...]
[CASCADE]
```

- `<USER>` 可为 `PUBLIC`，意为所有人。
- `CASCADE` 允许级联撤销权限。该命令此时会同时撤销所有由 `WITH GRANT OPTION` 派生的权限。

### Examples

```sql
REVOKE UPDATE(Sno)
ON Student
FROM shelpam
```

## Role

Role (角色) 是权限的集合，可以供 USER 使用。一个 USER 可以是多个 Character，同一操作的权限取“或”。

### Syntax

- 授权
```sql
GRANT <CHARACTER>
TO <USER> [<USER1> <USER2> ...]
```

- 撤销
```sql
GRANT <CHARACTER>
TO <USER> [<USER1> <USER2> ...]
```

## Mandotary Access Control and Discretionary Access Control

DAC (自主存取控制)：只对登录系统的用户进行验证，拷入U盘内加密失效。

MAC (强制存取控制)：对数据使用者的验证，拷入U盘内加密仍生效。

## Audit log

Audit log (审计) 把用户对数据库的所有操作自动记录并放入审计日志。

It's costly on time and space.
