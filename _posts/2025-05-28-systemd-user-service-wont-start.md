---
---

## What happened

My systemd service `clash` won't start on boot, which is under user mode.

## What I've done:

- In `[Unit]`, Change `After=network.target` to `After=default.target`. This is because that in user
  mode systemd services don't know about system level targets like `network.target`.

  You can view all the system level targets by `systemctl list-units -a`, and user level targets by
  `systemctl --user list-units -a`.
