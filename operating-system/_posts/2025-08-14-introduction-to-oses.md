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
