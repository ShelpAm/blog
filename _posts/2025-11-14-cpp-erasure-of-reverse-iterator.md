---
title: C++ - Erasure of container::reverse_iterator
tags:
- cpp
---

## TL;DR

To erase a `reverse_iterator rit`, use `container.erase(std::next(rit).base());`.

## Original Post

To erase a `reverse_iterator`, say `rit`, you can't directly call container's `erase` on it. Because
standard library doesn't have support for that. But you can use `rit.base()` to get the underlying
(bidirectional) iterator.

And the issue comes out: the iterator `reverse_iterator::base()` returns the iterator after the
element `rit` points to.

Let me draw a figure to make it clear:
```
begin ... rit rit.base() ... prev(end) end
  x   ...  y      z      ...    w     nullptr
```

So if you `erase(rit.base())`, the behavior is not the same as you considered to erase the element
`rit` pointing to. As a consequence, do it correctly with `erase(std::next(rit).base());`.
