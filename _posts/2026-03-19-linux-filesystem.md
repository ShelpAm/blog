---
title: Introduction to Linux Filesystem
tag:
  - linux
---

## Loop device

循环设备，是linux中的一种**虚拟块设备**，作用是把文件伪装成磁盘设备使用。

- 为什么叫循环设备？
- 因为通常读写路径为：应用 → 文件系统 → 块设备 (/dev/sda) → 硬盘，
- 而循环设备的读写路径为：应用 → 文件系统 → /dev/loop0 → 内核 → 普通文件 → 文件系统 → 磁盘，
  从写文件绕回到了写文件，而不是直接写磁盘。


