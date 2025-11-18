---
title: Strange Behavior of Fn Key Under Linux
---

Recently I re-install my fedora due to mis-erasing my disk partition table. After booting to the new
system, I found `F5` is not bound to refreshing the page.

Finally I found that this can be alternated by `echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode`.
To make the change persistent, use `echo "options hid_apple fnmode=0" | sudo tee -a /etc/modprobe.d/hid_apple.conf`.
