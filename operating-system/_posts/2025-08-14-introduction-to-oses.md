---
title: Introduction to OSes
---

## OS purposes

* Abstract the hardware
  * Both for convenient and portability
* Multiplex
  * Of applications
* Isolation
  * Between applications
* Sharing
  * Like files on the machine
* Security (Permission system / Access control system)
* Performance
* Range of uses

## OS organization

```
User Space: VI CC SH
-----------------------------
API-kernel (aka system calls)
  fd = open("out", 1) // `open` as a system call
                      // resides in the kernel.
-----------------------------
Kernel:  Processes   | FS
         Mem Alloc   |
         Access Crtl |
-----------------------------
Hardware:   CPU RAM DISK NET
```

## Why hard/interesting
* Unforgiving
* Tension
  * efficient - abstract
  * powerful - simple
  * flexible - secure

> QEMU is a hardware simulator. And we'll use it accross the course.
{: .prompt-tip }

## Useful links:

* [Schedule of MIT 6.S081 2024](https://pdos.csail.mit.edu/6.828/2024/schedule.html)
* [Lectures 2020](https://www.bilibili.com/video/BV19k4y1C7kA/?p=3&share_source=copy_web&vd_source=9d56f184caaa09e951606e4800ea1121)
