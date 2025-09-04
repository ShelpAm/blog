---
title: Page Tables
---

## Address spaces

An address space is the range of memory addresses that a process can reference.

### Memory management unit

Between CPU and memory, there is **memory management unit** (MMU), which translates virtual
addresses from CPU into physical addresses, and sends them to the memory.

Typically this mapping itself is also stored **in memory**. So the CPU has some register (**satp**,
Supervisor Address Translation and Protection register) that points to physical address of the page
table, and MMU would read that address, get the mapping from memory, and perform the translation.
Therefore, when switching running processes, the content of satp should be replaced as well.

## Paging hardware (RISC-V)

In RISC-V 64-bits registers can hold 2^64 addresses, so it's unreasonable to store all the addresses
in the page table. So it translates a page at a time, and a page on RISC-V is 4 kilobytes (4096
bytes). This is pretty common that almost all processors use page size 4k bytes, or support page
size 4k bytes. Naturely, a virtual address is splitted into two pieces: *index* and *offset*. Index
is actually translated into physical memory page number, while the offset indexes into the physical
page.

In fact, on the RISC-V processors that we're using, not all the 64 bits actually used. The top 25
bits are not used at all. So that limits the size of virtual address to 2^39 bytes, which is roughly
512 GB. For physical address space, RISC-V allows 56 bits address, where 44 bits for page number and
12 bits for offset.

### Multi-level structure of page table

If every process has a page table of 2^27 bytes addresses, it's still too large. In practice, it's a
multi-level structure:

![riscv-page-table-structure](/assets/images/riscv-page-table-structure.png)

In the image above, 27 bits index is splitted into three 9-bit parts: L2, L1, and L0. Each of the
parts indexes into the next page directory (i.e. top 9 bits to L2, middle 9 bits to L1, and last 9
bits to L3). In page directories, a **page table entry** (PTE) is 64 bits (as shown). It contains
**physical page number** (PPN) and flags, and PPN is the physical address of the next page
directory.

In this case, satp points to the page table for top 9 bits.

#### Advantages of multi-level structure

> If we need a page table, all the entries of it will take up spaces, i.e. you should pay for the
> whole page table if you use at least one entry.
{: .prompt-tip }

By converting 27-bit table into 3 9-bit tables, we are saving spaces. e.g. assume that we need one
page, we can just allocate 3 page tables (one for each part), consuming 3 * 512 * 8 = 12288 bytes.
With 27-bit huge table, the situation is using a whole large table of 2^27 * 8 = 1 GB. It's such a
huge cut on memory.

### Translation look-aside buffer

Every memory access requires walking up to three levels of page tables (L2, L1, and L0), which is
still expensive.

To speed this up, processors use a cache of recent translations called the **translation look-aside
buffer** (TLB). The TLB stores recently used PTEs, so most address translations can be done in one
step without a full walk.

The OS doesn't necessarily know how's the TLB implemented, but should know the existence of it.
That's because switching page tables invalidates the cache as it doesn't map things correctly
anymore. So when switching page tables, the TLB should also be flushed for consistency, or the
translation would be incorrect. By the way, the instruction to flush the TLB is called `sfence_vma`.

> Page tables provide level of indirection. This is an incredibly powerful machanism that will
> provide the operating system with tremendous amount of flexibility.
{: .prompt-tip }

> There are both cache for virtual address and for physical address in RISC-V processors.
{: .prompt-info }

## Xv6 VM layout

![address-space-mapping](/assets/images/address-space-mapping.png)

> The layout is determined by the board.
> The address space doesn't mean only address of memory but the whole motherboard.
{: .prompt-info }

Two interesting things to memtion:
* With page tables You can make one to one mapping, one to many mapping, many to one mapping; all that kind of stuff
  is possible.
  * In the picture (at upper left corner), between stacks are *guard page*s. If some stack goes
    overflow, then page fault will be raised. So stacking the guard page is one example of the cool
    trick that xv6 uses, mostly to track down bugs.
* xv6 support permissions for virtual address (also shown in the picture). This helps us catch bugs
  early.

<!-- It's worth memtioning that every user process has its own kstack. -->
### Xv6 Code

`kvmmap` is used for adding maps from virtual address to physical address. In `vm.c:kvminit()` we
can see that devices and registers are identity-mapped.

Care must be taken after calling the `w_satp` function to set `satp` to the page table, because the
world changes: every physical address previously used is now interpreted as a virtual address. The
reason it still works in this case is that we used identity mapping, so nothing breaks.
