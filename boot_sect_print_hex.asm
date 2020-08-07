; recieve the data in dx
; for example we'll assume dx=0x1234

print_hex:
    pusha

    mov cx, 0 ; index variable

; Get the last character of dx and convert to ASCII
; Numberic ASCII: '0' (0x30) to 9 (0x39) so just add 0x30 to N byte
; Alphabetic A-F: 'A' (0x41) to 'F' (0x46) so add 0x40
; Move ASCII to correct position in string

hex_loop:
    cmp cx, 4 ; loop 4 times
    je end

    ; 1. convert last char of dx to ascii
    mov ax, dx ; ax is working register
    and ax, 0x000f ; 0x1234 - > 0x0004 by masking first three to 0
    add al, 0x30 ; add 0x30 to N byte cpnverts to ASCII "N"
    cmp al, 0x39 ; if >9, add extra 8 to represent 'A' to 'F'
    jle step2
    add al, 7 ; 'A' is ASCII 6 instead of 85, so 65-58=7

step2:
    ; 2. get the correct position of the string to place our ASCII char
    ; bx <- base address + string length - index of char
    mov bx, HEX_OUT + 5 ; base + length
    sub bx, cx ; index variable
    mov [bx], al ; copy ASCII char on al to position pointed by bx
    ror dx, 4 ; 0x1234 -> 0x4123 -> 0x3412 -> 0x2341 -> 0x1234

    ; increment index and loop
    add cx, 1
    jmp hex_loop

end:
    ; prepare the parameter and call the function
    ; remember that print recieves parameters in bx
    mov bx, HEX_OUT
    call print

    popa
    ret

HEX_OUT:
    db '0x0000', 0 ; reserver memory for our new string
