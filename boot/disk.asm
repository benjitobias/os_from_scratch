; load dh sectors from drive dl into ES:BX
disk_load:
    pusha
    ; reading from disk requires setting specfic values in all registers
    ; save dx to the stack for later use as we are overwriting it for int
    push dx

    mov ah, 0x02 ; ah <- int 0x13. 0x02 = 'read'
    mov al, dh ; al <- number of sectors ro read (0x01 .. 0x80)
    mov cl, 0x02 ; cl <- sector (0x01 .. 0x11)
                 ; 0x01 is our boot sector, 0x02 is the first 'available' sector
    ; dl <- drive number. Our caller sets it as a parmeter and gets it from the BIOS
    ; (0 = floppy, 1 = floppy2, 0x80 = hdd, 0x81 = hdd2)
    mov dh, 0x00 ; dh <- head number (0x0 .. 0xF)
    
    ;[es:bx] <- pointer to buffer where the data will be stored
    ; caller sets it up for us and it is actually the standard location for int 13h
    int 0x13 ; BIOS interrupt
    jc disk_error ; (if error, stored in carry bit)

    pop dx
    cmp al, dh ; BIOS also sts al to the number of sectors read. Compare it
    jne sectors_error
    popa
    ret

disk_error:
    mov bx, DISK_ERROR
    call print
    call print_nl
    mov dh, ah ; ah = error code, dl = disk drive that caused the error
    call print_hex ; check the code at http://stanislavs.org/helppc/int_13-1.html
    jmp disk_loop

sectors_error:
    mov bx, SECTORS_ERROR
    call print

disk_loop:
    jmp $

DISK_ERROR: db "Disk read error", 0
SECTORS_ERROR: db "Incorrect numbers of sectors read", 0
