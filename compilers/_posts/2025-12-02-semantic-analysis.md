---
title: Compilers - Semantic Analysis with Formal Grammar
---

At least the following three tables are involved in semantic analysis:
- Symbol table stores information about identifiers seen by semantic parser.
- Type table
- Constants table

## Internal representation of indentifiers

```cpp
{% include_relative identifier.h %}
```

## Symbol table

When seeing
- definition of a symbol, parser _registers_ it in the symbol table.
- usage of a symbol, parser _finds_ it in the symbol table.

Finding symbols in table is easy peasy, but be careful about the [scope](#scope).

## Scope

No two identifiers in the same scope can have the same name. It's ambiguous.

Embedding rule:
- A scoped identifier can't be fetched outside its scope, but can be used in inner scope.
- If more than one identifiers can be seen in current scope, identifier in the deepest level is used.

## See also

- c4 - a minimal c compiler in four functions (500 lines).

