## Terms

### PRIME render offload

PRIME render offload is the ability to have an X screen rendered by one GPU, but choose certain
applications within that X screen to be rendered on a different GPU.

### DRM KMS

The full name of DRM KMS is *direct rendering manager kernel mode setting*.

The capabilities of this DRM driver depend on the Linux kernel version and configuration.

NVIDIA's DRM KMS support is still considered experimental. It is disabled by default, but can be
enabled on suitable kernels with the 'modeset' kernel module parameter. E.g.,
```bash
modprobe -r nvidia_drm ; modprobe nvidia_drm modeset=1
```

See <https://download.nvidia.com/XFree86/Linux-x86_64/580.76.05/README/kms.html> for more details.

Kernel mode setting (KMS) is a method for setting display resolution and depth in the kernel space
rather than user space. See <https://wiki.archlinux.org/title/Kernel_mode_setting> for more details.

### DKMS

DKMS stands for "dynamic kernel module support". It's targeted at dynamically building kernel
modules if corresponding modules are not detected. The DKMS variants are not tied to a specific
kernel, as they recompile the NVIDIA kernel module for each kernel for which header files are
installed.

## FAQ

### What are mkinitcpio, dracut and grubby?

`mkinitcpio` and `dracut` are generators for initramfs. And `grubby` is tool for tweaking grub
configs in a robust way and automatically generating `/boot/grub2/grub.cfg` when new kernels are
installed. For manually generating `/boot/grub2/grub.cfg`, use `grub2-mkconfig`. e.g. its typical
usage is `grub2-mkconfig -o /boot/grub2/grub.cfg`.

See <https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/system_administrators_guide/ch-working_with_the_grub_2_boot_loader>.
