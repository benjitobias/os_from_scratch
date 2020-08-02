# os_from_scratch
Fresh start of os_dev using https://github.com/cfenollosa/os-tutorial

## 01-bootsector-barebones

### Goal: Create a file with the BIOS interprets as a bootable disk

Bootloader recoginses a drive as bootable by bytes 511 and 512 being 0xAA55 (pay attention to endianess, it comes out as `55 aa`).



### Notes
To view the disassembly of the compiled binary use either
`ndisam -b32 <binary>`
or
`objdump -D -b binary -mi386 -M intel <binary>`

