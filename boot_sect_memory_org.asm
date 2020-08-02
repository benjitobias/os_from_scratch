; define global offset
[org 0x7c00]

mov ah, 0x0e

; attempt 1
; Still fails because it tries to print the pointer not the contents

mov al, "1"
int 0x10
mov al, the_secret
int 0x10

; attempt 2
; This now works and is the correct method since the offset is sorted

mov al, "2"
int 0x10
mov al, [the_secret]
int 0x10

; attempt 3
; This no longer works because we are adding 0x7c00 to the 0x7c00 we have already added

mov al, "3"
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; attempt 4
; This still works because we are addressing the memory directly without pointer
; but this method is extremely inconvenient

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
