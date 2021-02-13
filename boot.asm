    section .text
global _start

_start:
    ; bootloader is loaded at present address
    [org 0x7c00]

    ; Set BIOS screen to TTY mode
    mov ah, 0x0E

    ; Set stack to slightly above end of boot sector as it grows downwards
    ; Stack size = 0x8000 - (0x7c00 + 0x01FF)
    mov bp, 0x8000
    mov sp, bp
    
    ; Print character to screen, then invoke BIOS video interrupt
    mov al, 'H'
    int 0x10
    mov al, 'e'
    int 0x10
    mov al, 'l'
    int 0x10
    mov al, 'l'
    int 0x10
    mov al, 'o'
    int 0x10

    ; Infinite loop
    jmp $
 
    ; Pad boot sector (512 Bytes) with 0
    times 510-($-$$) db 0

    ; End of boot sector indicator
    dw 0xaa55
