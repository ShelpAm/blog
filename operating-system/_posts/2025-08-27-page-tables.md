---
title: Page Tables
---

## Address spaces

An address space is the range of memory addresses that a process can reference.

### Memory management unit

Between CPU and memory, there is memory management unit, which translates virtual addresses from CPU
into physical addresses to memory.

Typically this mapping itself is also stored in memory. So the CPU has some register (satp) that
points to physical address of the page table, and MMU would read that address, get the mapping from
memory, and perform the translation.

Therefore, when switching running processes, the content of satp will be replaced.

In RISC-V 64-bits registers can hold 2^64 addresses, so it's unreasonable to store all the addresses
in the page table. So you translate a page at a time, and a page on RISC-V is 4 kilobytes (4096
bytes). The is pretty common that almost all processors use page size 4k bytes, or support page size
4k bytes.

Naturely, a virtual address is splitted into two pieces: index and offset. Index is actually
translated into physical memory page number, while the offset indexes into the physical page.

In fact, on the RISC-V processors that we're using, not all the 64 bits actually used. The top 25
bits are not used at all. So that limits the size of virtual address to 2^39 bytes, which is roughly
512 GB.

For physical address space, RISC-V allows 56 bits address, which consists of 2^44 pages and 2^12
bytes in a page.

## Paging hardware (RISC-V)

## Xv6 VM layout
