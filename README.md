# os_from_scratch
Fresh start of os_dev using https://github.com/cfenollosa/os-tutorial

## 02-bootsector-barebones

### Goal: Make silent boot sector print text

Write 'Hello' int to the `al` register `0x0e` into  `ah` and raise `0x10` interrupt (general video services)

`0x0e` on `ah` tells the video interrupt that we want to write the contents of `al` in tty mode


### Notes

According to the guide, `xdd <filename>` also prints the disassembly
