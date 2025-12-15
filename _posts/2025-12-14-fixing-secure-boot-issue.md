---
title: Fixing NVIDIA Driver "Unavailable Key" Error After a Windows Update
---

Recently, I ran into an issue with the NVIDIA driver after an unexpected Windows update. The update
reordered the BIOS boot entries, and when I subsequently booted into Fedora 43, the NVIDIA kernel
module failed to load with an "unavailable key" error.

I have been using the proprietary NVIDIA driver with Secure Boot enabled for a long time without any
issues, so this behavior was unexpected. However, after researching the problem, I discovered that
the Secure Boot signing key previously enrolled on my system was no longer recognized, likely due to
changes triggered by the Windows update or the altered boot configuration.

After some investigation, I was able to resolve the issue by manually importing the NVIDIA module
signing key into the system’s Machine Owner Key (MOK) database. Fedora provides official
documentation for this process under [How to / Secure Boot][HowTo/SecureBoot]. Even if you are not
using Fedora, this guide can serve as a useful reference.

In short, the fix was:

1. Import the module signing key into the system.
2. Enroll the key via MOK during the next boot.
3. Reboot and verify that the NVIDIA driver loads correctly under Secure Boot.

Once the key was properly enrolled, the NVIDIA driver loaded as expected, and Secure Boot remained enabled.

[HowTo/SecureBoot]: https://rpmfusion.org/Howto/Secure%20Boot

> This article is polished by AI, and proofreaded.
{: .prompt-info }
