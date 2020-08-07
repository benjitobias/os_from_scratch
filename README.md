# os_from_scratch
Fresh start of os_dev using https://github.com/cfenollosa/os-tutorial

## 07-bootsector-disk

### Goal: Let the bootsector load data from the disk in order to boot the kernel

Our OS won't fit inside the bootsector 512 bytes so we need to read data from the disk.
We can use BIOS routines, like when printing, to read.
Set `al` to `0x02` (and other registers with the required cylinder, head and sector) and raise int `0x13`

[man int13h](https://stanislavs.org/helppc/int_13-2.html)

The BIOS sets `al` to th numbers of sectors read.

We'll use the carry bit here. `jc` (jump if carry)

### Notes

