mov ah, 0x0e

; attempt 1
; Fails because it tries to print the pointer not the contents

mov al, "1"
int 0x10
mov al, the_secret
int 0x10

; attempt 2
; Tries to print the address of 'the_secret' but the BIOS places our
; bootsector at address 0x7c00 so we need to add padding (in attempt 3)

mov al, "2"
int 0x10
mov al, [the_secret]
int 0x10

; attempt 3
; Add the BIOS starting offset 0x7c00 to the address of the X
; and then dereference the contents of that pointer.
; We need the help of a different register 'bx' becuase 'mov al, [ax] is illegal.
; A register can't be used as source ans destination

mov al, "3"
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; attempt 4
; Try a shortcut because we know that the X is stored at byte 0x2d in our binary
; Smart but ineffective, we don't want to be counting label offsets at every code change

mov al, "4"
int 0x10
mov al, [0x7c2d]
int 0x10

jmp $ ; infinite loop

the_secret:
    ; ASCII code 0x58 ('X') is stored just before the zero padding
    ; In this code that's at byte 0x2d (view using 'xdd file.bin')
    db "X"

; zero padding and magic number
times 510 - ($ - $$) db 0
dw 0xaa55
