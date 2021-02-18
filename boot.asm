; Copyright (c) 2021 Ojas Anand.
;
; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation;
; either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
; You should have received a copy of the GNU General Public License along with this program. If not, see https://www.gnu.org/licenses/. 


   SECTION .TEXT
GLOBAL _START

_START:
    ; OPERATE IN 16-BIT MODE & REMEMBER THAT BOOTLOADER IS LOADED AT PRESENT ADDRESS
    [BITS 16]
    [ORG 0x7C00]

    ; SET STACK TO SLIGHTLY ABOVE END OF BOOT SECTOR AS IT GROWS DOWNWARDS
    ; STACK SIZE = 0x8000 - (0x7C00 + 0x01FF)
    MOV BP, 0x8000
    MOV SP, BP
    
    MOV [BOOT_DRV], DL     ; REMEMBER BOOT DRIVE STORED IN DL FOR LATER
    MOV BX, 0x9000         ; LOAD 5 SECTORS TO 0x0000(ES):0x9000(BX)
    MOV DH, 5              ; FROM BOOT DISK
    MOV DL, [BOOT_DRV]     ; LOAD BOOT DRIVE TO DL 
    CALL DSK_LD            ; CALL DISK LOAD FUNCTION
    
    ; PRINT FIRST LOADED WORD (0xDADA)
    MOV AX, [0x9000]
    CALL PRNT_HEX
    
    ; PRINT FIRST WORD FROM SECOND LOADED SECTOR
    MOV AX, [0x9000 + 512]
    CALL PRNT_HEX

    JMP $   ; INFINITE LOOP
 
    ; LOAD DH SECTORS TO ES:BX FROM DRIVE DL
    DSK_LD:
    PUSHA           ; PUSH ALL REGISTER VALUES TO THE STACK
    PUSH DX         ; PUSH DX TO THE STACK AS WE WILL NEED IT FOR LATER

    MOV AH, 0x02    ; BIOS READ SECTOR FUNCTION
    MOV AL, DH      ; READ DH SECTORS
    MOV CH, 0x00    ; SELECT CYLINDER 0
    MOV DH, 0x00    ; SELECT HEAD 0
    MOV CL, 0X02    ; START READING FROM SECOND SECTOR (BOOT SECTOR IS THE FIRST ONE, I.E. THIS ONE)
    INT 0x13        ; BIOS READ INTERRUPT
    
    JC DSK_ERR      ; JUMP IF CARRY FLAG IS SET (ERROR INDICATED)

    POP DX          ; RESTORE DX FROM THE STACK
    CMP DH, AL      ; IF AL != DH (SECTORS READ VS SECTORS EXPECTED)
    JNE DSK_ERR     ; DISP ERR

    POPA            ; RETURN ALL REGISTERS PUSHED TO THE STACK TO THEIR ORIGINAL LOCATIONS
    RET             ; FUNCTION RETURN 

    ; DISK ERROR HANDLING
    DSK_ERR:
    MOV SI, DSK_ERR_MSG
    CALL PRNT_STR
    JMP $
 
    ; PRINT STRING POINTED AT BY SI REGISTER
    PRNT_STR:
    PUSHA           ; PUSH ALL REGISTER VALUES TO THE STACK

    LODSB           ; LOAD BYTE AT ADDRESS DS:(E)SI INTO AL MOV AH, 0X0E ; SET BIOS SCREEN TO TTY MODE
    MOV AH, 0x0E    ; SET BIOS SCREEN TO TTY MODE

    PRINT_LOOP:
    INT 0x10
    LODSB
    CMP AL, 0
    JNE PRINT_LOOP
    
    POPA
    RET

    ; PRINT HEX VALUE AT AX AS STRING LITERAL 
    PRNT_HEX:
    PUSHA           ; PUSH ALL REGISTER VALUES TO THE STACK

    MOV BX, 2

    MOV DL, AH 
    SHR DL, 4 
    CALL SET_HEX_OUT
    INC BX
 
    MOV DL, AH
    AND DL, 0x0F
    CALL SET_HEX_OUT
    INC BX
    
    MOV DL, AL
    SHR DL, 4
    CALL SET_HEX_OUT
    INC BX
 
    MOV DL, AL
    AND DL, 0x0F
    CALL SET_HEX_OUT
    INC BX

    MOV SI, HEX_OUT
    CALL PRNT_STR

    POPA
    RET

    SET_HEX_OUT:
    CMP DL, 9
    JG CORRECTION
    OR DL, 0x30
    MOV [HEX_OUT+BX], DL
    RET

    CORRECTION:
        SUB DL, 9
        OR DL, 0x40
        MOV [HEX_OUT+BX], DL
    RET

    ; GLOBAL VARS 
    BOOT_DRV: DB 0
    DSK_ERR_MSG: DB 'DISK READ ERROR!', 0
    HEX_OUT: DB '0x0000', 0

    ; BOOT SECTOR PADDING AND END INDICATOR 
    TIMES 510-($-$$) DB 0
    DW 0xAA55

    ; TEST DISK LOAD
    TIMES 256 DW 0xDADA
    TIMES 256 DW 0xFACE
