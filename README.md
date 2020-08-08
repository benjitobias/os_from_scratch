# os_from_scratch
Fresh start of os_dev using https://github.com/cfenollosa/os-tutorial

## 13-kernel-barebones

### GOAL: Create a simple kernel and a bootsector capable of booting it
#####The kernel

Our C kernel will just print an 'X' on the top left corner of the screen: `kernel.c`

There is a dummy function that does nothing/ That function will force us to create a kernel entry routine which does not point to byte 0x0 in our kernel but to an actual label which we know launches it.
In our case, function `main()`.

`i386-elf-gcc -ffreestanding -c kernel.c -o kernel.o`

That routine is coded on `kernel_entry.asm`. Inside there is an `[extern]` declaration.
To compile this file, instead of generating a binary, we will generate an `elf` format file which will be linked with `kernel.o`

`nasm kernel_entry.asm -f elf -o kernel_entry.o`

#####The linker
A linker is a very powerful tool and we only started to benefit from it.

To link both object files into a single binary kernel and resolve label references, run:
`i386-elf-ld -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o --oformat binary`

Notice how our kernel will be places not a `0x0` in memory but at `0x1000`. The bootsector will need to know this address too.

#####The bootsector
It is very similar to the one in lesson 10. Without the print message lines, it comes around at only a couple dozen lines.

Compile with `nasm bootsect.asm -f bin -o bootsect.bin`

#####Putting it all together
Now we have 2 separate files for the bootsector and the kernel.

Link them into a single file by just concatenating them!

`cat bootsect.bin kernel.bin > os-image.bin`

#####Run!

You can now run `os-image.bin` with qemu

Remember that if you find disk load errors you may need to play with the disk numbers or qemu parameters (floppy = `0x0`, hdd = `0x80`). I usually use `qemu-system-i386 -fda os-image.bin`

You will see four messages:

* "Started in 16-bit Real Mode"
* "Loading kernel into memory"
* (Top left) "Landed in 32-bit Protected Mode"
* (Top left, overwriting previous message) "X"
* Congratulations!

#####Makefile
Tidy up the compilation process with a Makefile

### Notes

