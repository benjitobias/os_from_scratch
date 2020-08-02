# os_from_scratch
Fresh start of os_dev using https://github.com/cfenollosa/os-tutorial

## 03-bootsector-memory

### Goal: Learn how the computer memory is organised

Read page 14 [of this document](https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf)<sup>1</sup> and look at the memory layout

boot_sect_memory.asm provide a few example of the incorrect methods to use memory (although some do work).
boot_sect_memory_org.asm displays the correct way using a global offset definition defined by `[org 0x7c00]`.
The correct method is *attempt 2* in *boot_sect_memory_org.bin*.


[1] The tutorial is heavily inspired by this document

### Notes

