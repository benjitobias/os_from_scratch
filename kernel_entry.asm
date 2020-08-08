[bits 32]
[extern main] ; Define calling point. Must have the same name as kernel.c 'main' function
call main ; Calls the C funtion. The linker will know where it is places in memory
jmp $
