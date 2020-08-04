mov ah, 0x0e ; tty

mov al, [the_secret]
int 0x10 ; we know this doesn't work right?

mov bx, 0x7c0 ; remember, the segment is automatically <<4 for you
mov ds, bx

; WARNING: all memory references will now be offset by ds implicitly
mov al, [the_secret]
int 0x10

mov al, [es:the_secret]
int 0x10 ; doesn't look right, es is currently 0x000

mov bx, 0x7c0
mov es, bx
mov al, [es:the_secret]
int 0x10

jmp $

the_secret:
    db 'X'

times 510 - ($-$$) db 0
dw 0xaa55
