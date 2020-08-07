# os_from_scratch
Fresh start of os_dev using https://github.com/cfenollosa/os-tutorial

## 09-32bit-gdt

### GOAL: Program the GDT

Remember segmentation from lesson 6? The offset was left shifted to address an extra level of indirection.

In 32-bit mode, segmentation works differently. Now, the offset becomes an index to a segment descriptor (SD) in the GDT. This descriptor defines the base address (32 bits), the size (20 bits) and some flags, like readonly, permissions, etc. To add confusion, the data structures are split, so open the [os-dev.pdf file](https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf) and check out the figure on page 34 or the Wikipedia page for the GDT.

The easiest way to program the GDT is to define two segments, one for code and another for data. These can overlap which means there is no memory protection, but it's good enough to boot, we'll fix this later with a higher language.

As a curiosity, the first GDT entry must be `0x00` to make sure that the programmer didn't make any mistakes managing addresses.

Furthermore, the CPU can't directly load the GDT address, but it requires a meta structure called the "GDT descriptor" with the size (16b) and address (32b) of our actual GDT. It is loaded with the `lgdt` operation.

### Notes
[GDT](https://wiki.osdev.org/GDT)
[GDT Tutorial](https://wiki.osdev.org/GDT_Tutorial)
