---
title: C++ - Basic Multithreaded Programs
tag:
  - cpp
---

In operating systems, we all know P/V operations can serve as mutual exclusion and synchronization primitives, but how they should be implemented in C++? In this article, I'll tell you all about how to write a basic multithreaded C++ program.

## Mutual exclusion primitive

A simple and classic example:

```cpp
#include <mutex>
#include <thread>

std::mutex m;
void worker1() {
    while (true) {
        std::scoped_lock lock(m); // Acquires lock on mutex m
        // critical section
        // lock will be automatically released here thanks to RAII.
    }
}
void worker2() {
    while (true) {
        std::scoped_lock lock(m); // Same as above
        // critical section
    }
}
void some_func() {
    // You may call them somewhere like this...
    std::jthread t1(worker1);
    std::jthread t2(worker2);
}
```

In loops, the two workers both competes for the `std::mutex m`. One will succeed, and the other blocks and waits for the next release.

## Synchronization primitive

This is a bit harder to follow.

First, let's see what a first attempt looks like:

```cpp
#include <mutex>
#include <print>
#include <queue>
#include <thread>

int main()
{
    std::queue<int> q;
    std::mutex m;
    std::jthread writer([&] {
        int i{};
        while (true) {
                std::scoped_lock lock(m);
                q.push(i++);
        }
    });
    std::jthread reader([&] {
        while (true) {
            int t;
            {
                std::scoped_lock lock(m);
                // Performance issue here: if most of the time the queue is empty,
                // the reader will spin and waste CPU cycles.
                if (q.empty()) {
                    continue;
                }

                t = q.front();
                q.pop();
            }
            std::println("Read: {}", t);
        }
    });
}
```

It's a correct program, but inefficient if most of the time the queue is empty. So we need a notification mechanism: only when the queue contains some data, the reader reads them from it. Consider the following example:

```cpp
#include <condition_variable>
#include <mutex>
#include <print>
#include <queue>
#include <thread>

int main()
{
    std::condition_variable cv;
    std::mutex m;
    std::queue<int> q;
    std::jthread writer([&] {
        int i{};
        while (true) {
            {
                std::scoped_lock lock(m);
                q.push(i++);
            }
            cv.notify_one();
        }
    });
    std::jthread reader([&] {
        while (true) {
            int t;
            {
                std::unique_lock lock(m);
                cv.wait(lock, [&] { return !q.empty(); }); // Wait until q is not empty.
                t = q.front();
                q.pop();
            }
            std::println("Read: {}", t);
        }
    });
}
```

But why does `cv.wait` need a lock, and how they work together? This remains to be solved next time.
