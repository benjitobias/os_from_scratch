[bits 32] ; using 32-bit protected mode

; this is how constants are defined

VIDEO_MEMORY equ 0xb8000
; WHITE_ON_BLACK equ 0x0f ; the colour bytes for each character
WHITE_ON_BLUE equ 0x1f ; the colour bytes for each character

print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY

print_string_pm_loop:
    mov al, [ebx] ; ebx is the address of our character
    mov ah, WHITE_ON_BLUE

    cmp al, 0 ; check if null terminator
    je print_string_pm_done

    mov [edx], ax ; store the character + attribute in video memory
    add ebx, 1 ; next char
    add edx, 2 ; next video memory position

    jmp print_string_pm_loop

print_string_pm_done:
    popa
    ret
