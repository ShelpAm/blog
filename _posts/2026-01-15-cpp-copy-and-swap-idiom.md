---
title: C++ - Copy-and-swap Idiom
---

I faced an issue implementing BusTub P1 correctly. It's all about move semantic and resource
ownership. I found the "copy-and-swap idiom" very helpful in solving this problem. Here's a brief
explanation of the idiom and how it can be applied in C++.

## Motivation

### Resource management challenges

When implementing copy/move constructors and assignment operators, we often need to _release_
allocated resources. But this is easy to forget, leading to resource leaks or double frees.

### Exception safety

`swap(x, y)` is usually implemented `noexcept`, so it won't throw exceptions. This property helps
ensure that our assignment operators are not leading to resource leaks.

## Mechanism

```cpp
class Widget {
  public:
   // You should implement these two as usual.
    Widget(Widget const& other);
    Widget(Widget&& other) noexcept;

    Widget& operator=(Widget other) noexcept {   // note: pass by value
        if (this != &other) swap(*this, other);  // swap the contents
        return *this;
    }

  private:
    friend void swap(Widget& first, Widget& second) noexcept {
        using std::swap;
        // swap all members here, e.g.:
        // swap(first.member1, second.member1);
        // swap(first.member2, second.member2);
    }
};
```
