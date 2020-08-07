# os_from_scratch
Fresh start of os_dev using https://github.com/cfenollosa/os-tutorial

## 08-32bit-print

### GOAL: Print on the screen when in 32-bit protected mode

32-bit mode allows us to use 32 bit registers and memory addressing, protected memory, virtual memory and other advantages but we will lose BIOS interrupts and we'll need to code the GDT (more on this later).

In this lesson we will write a new print string routine which works in 32-bit mode, where we don't have BIOS interrupts, by directly manipulating the VGA video memory instead of calling int 0x10. The VGA memory starts at address 0xb8000 and it has a text mode which is useful to avoid manipulating direct pixels.

The formula for accessing a specific character on the 80x25 grid is:

`0xb8000 + 2 * (row * 80 + col)`

That is, every character uses 2 bytes (one for the ASCII, another for color and such), and we see that the structure of the memory concatenates rows.

For now it will always print on the top left of the screen but soon we'll change that with higher level routines.

Unfortunately, we cannot call this brom the bootloader yet as we still don't know how to write the GDT and enter protected mode.

### Notes

[Printing to screen](https://wiki.osdev.org/Printing_To_Screen)
[VGA Hardware](https://wiki.osdev.org/VGA_Hardware)
[Protected Mode](https://wiki.osdev.org/Protected_Mode)
