Some registers that may help work out the error in riscv:
* scause (Supervisor Cause Register) indicates the type of the page fault.
* sepc: Supervisor Exception Program Counter
* stval (Supervisor Trap Value) contains the address that couldn't be translated.

I'm a big fool! I misused strcpy, and tried to use it to compare a NULL-terminated string to a pointer,
returning 0 if the prefixes match. It took me hours to realize...

