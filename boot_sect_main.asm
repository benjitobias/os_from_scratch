[org 0x7c00] ; global offset to bootsector code

; Main routine makes sure the parameters are ready and then calls the function

mov bx, HELLO
call print

call print_nl

mov bx, GOODBYE
call print

call print_nl

mov dx, 0x12fe
call print_hex

; that's it, we can hang now

jmp $

; include subroutines

%include "boot_sect_print.asm"
%include "boot_sect_print_hex.asm"

; data

HELLO:
    db 'Hello, World', 0

GOODBYE:
    db 'GOODBYE', 0

; padding and magic number

times 510-($-$$) db 0
dw 0xaa55
