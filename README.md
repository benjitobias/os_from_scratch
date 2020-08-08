# os_from_scratch
Fresh start of os_dev using https://github.com/cfenollosa/os-tutorial

##10-32bit-enter 

### GOAL: Enter 32-bit protected more and test code from previous lessons

To jump into 32-bit mode:
    1. Disable interrupts
    2. Load out GDT
    3. Set a bit on the CPU control register to `cr0`
    4. Flush the CPU pipeline by issueing a carefully crafted jump
    5. Update all the segment registers
    6. Update the stack
    7. Call a well-known label which contains the first useful code in 32 bits

We will encapsulate this process in the file `32bit-switch.asm`

After entering 32-bit mode, we will call `BEGIN_PM` which is the entry point for actual useful code (eg kernel code, etc).

### Notes
[GDT](https://wiki.osdev.org/GDT)
[GDT Tutorial](https://wiki.osdev.org/GDT_Tutorial)
