# Nvidia kernal module missing on startup

## Problem

Recently, I upgraded my linux kernel to version 6.13.0 and 6.14. But I could see
"Nvidia kernal module missing" in both version after reboot.

It seemed that I didn't install corresponding nvidia graphic card driver. And
`sudo akmods --force` wouldn't fix the bug.

(I'm using Fedora 42)

## Thoughts

Searching the web, I found this post:
https://discussion.fedoraproject.org/t/nvidia-kernel-module-missing-falling-back-to-nouveau/146642
. Thanks to [leigh123linux](leigh123linux), here is what he said:

> You can disable compression in /usr/lib/rpm/macros.d/macros.kmodtool , edit line#67
>
> ```
> # It is also possible to uncomment one of the macros provided below:
> %_kmodtool_zipmodules 0
> #%%_kmodtool_zipmodules 1
> ```

So here comes the solution.

## Solution

0. If you don't have akmods in your system, install it by `sudo dnf install akmods`.
1. Edit /usr/lib/rpm/macros.d/macros.kmodtool, uncomment line 67 to `%_kmodtool_zipmodules 0`.
2. `sudo akmods --force`
3. Reboot your computer.

[leigh123linux]: https://discussion.fedoraproject.org/u/leigh123linux
