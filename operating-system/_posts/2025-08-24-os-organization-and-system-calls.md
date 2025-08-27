---
title: OS Organization and System Calls
---

## Isolation

### Real world examples

Think in Strawman design:
* If no operating system, there is no strong isolation between programs.

Unix interface abstracts the hardware resources.
* processes: instead of CPU
* exec: instead of memory (e.g. to load a program to memory, you should call `exec`.)
* files: instead of disk blocks

### OS should be defensive

We must keep that:
* app cannot crash the OS.
* app cannot break out of its isolation.

=> There must be strong isolation between apps and OS.

=> Typically done by: hardware support

And hardware support contains the following two ways:
1. [user/kernel mode](#userkernel-mode)
2. [virtual memory](#virtual-memory)

Almost every processor has support for the two ways.

## User/kernel mode

| Mode | Allowed Instructions | Examples |
|---|---|---|
| Kernel mode | Priviledged Instructions | setting up page table, disabling clock interrupts |
| User mode | Unpriviledged Instructions | `add`, `sub`, `jr`, branch |

Priviledged instructions are instructions that are basically involved in manipulating the hardware
directly.

### Transition from user mode to kernel mode

|Step|Mode|Action|
|---|---|---|
|1|user|system call wrapper in c library|
|2|user|ecall instruction|
|3|kernel|syscall|
|4|kernel|do corresponding action|

Kernel should check parameters taken from the calling side to not be tricked. In this view the the
world, the kernel is sometimes called **trusted computing base** (TCB).
* Kernel must have no bugs.
* Kernel must treat processes as malicious.

### What should be run in kernel mode

When the whole OS is run in the kernel, it's called **monolithic kernel design** (宏内核). The downside of it
is too many code running in kernel, raising up more security issues. But tight integration between
modules leads to great performance.

Another design, which basically focuses on reducing the amount of code in the kernel is what's
called **micro kernel design** (微内核). So in this design, kernel is small, which means fewer bugs.
But different pieces are well isolated, and a tight integration is less. Therefore, it's sometimes
more difficult to get high performance.

## Virtual memory

Page table maps virtual addresses to physical addresses. Every process has own page table, and can
only access addresses in the page table. And this gives us very strong memory isolation.

To learn more details, see [Page Tables]({% post_url operating-system/2025-08-27-page-tables %}).
