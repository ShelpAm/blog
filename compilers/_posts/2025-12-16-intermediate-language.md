---
title: Compilers - Intermediate Language
---

It's a platform-independent language that abstracts above object code.

## Intermediate code

栈式中间代码-后缀式

四元式
- `(op, arg1, arg2, result)`

> [!INFO]
> 如果你是江西师大的学生，那还需要知道以下注意事项：
> - 输入输出的写法：
>   - readi 读入整型
>   - readf 读入浮点型
>   - writei 写入整型
>   - writef 写入浮点型
> - 标签跳转
>   - `LABEL, labelname`: 创建一个名为 labelname 的标签
>   - `JUMP, labelname`: 直接跳转到 labelname 处
>   - `JUMP0, cond, labelname`: 若 cond 为 0，则跳转到 labelname 处
>   - `JUMP1, cond, labelname`: 若 cond 为 1，则跳转到 labelname 处
{: .prompt-tip }

三元式
- `(op, arg1, arg2)`
- arg 可为 `(<序号>)`，表示第 `<序号>` 个三元式的结果；如 2 + 1 * 3 可表示为
  ```
  (*, 1, 3)
  (+, 2, (0))
  ```

多元式

由于后缀式、四元式和三元式主要面向表达式，而代码的其他部分需要有不同数目的分量，故提出多元式的概念。


AGT

DAG

## Intermediate language


