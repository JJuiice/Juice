; Copyright (c) 2021 Ojas Anand.
;
; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation;
; either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
; You should have received a copy of the GNU General Public License along with this program. If not, see https://www.gnu.org/licenses/. 


   SECTION .TEXT
GLOBAL _START

_START:
    ; BOOTLOADER IS LOADED AT PRESENT ADDRESS
    [ORG 0X7C00]

    ; SET STACK TO SLIGHTLY ABOVE END OF BOOT SECTOR AS IT GROWS DOWNWARDS
    ; STACK SIZE = 0X8000 - (0X7C00 + 0X01FF)
    MV BP, 0X8000
    MOV SP, BP
    
    ; PRINT STRING TO SCREEN, THEN INVOKE BIOS VIDEO INTERRUPT
    MOV SI, HELLO
    CALL PRINT_STRING

    MOV AX, 0XEF8D
    CALL PRINT_HEX

    ; INFINITE LOOP
    JMP $
 
    PRINT_STRING:
    PUSHA

    LODSB
    ; SET BIOS SCREEN TO TTY MODE
    MOV AH, 0X0E
    PRINT_LOOP:
    INT 0X10
    LODSB
    CMP AL, 0
    JNE PRINT_LOOP
    
    POPA
    RET

    PRINT_HEX:
    PUSHA

    MOV BX, 2

    MOV DL, AH 
    SHR DX, 4
    CALL SET_HEX_OUT
    INC BX
 
    MOV DL, AH
    AND DL, 0X0F
    CALL SET_HEX_OUT
    INC BX
    
    MOV DL, AL
    SHR DX, 4
    CALL SET_HEX_OUT
    INC BX
 
    MOV DL, AL
    AND DL, 0X0F
    CALL SET_HEX_OUT
    INC BX

    MOV SI, HEX_OUT
    CALL PRINT_STRING

    POPA
    RET

    SET_HEX_OUT:
    CMP DL, 9
    JG CORRECTION
    OR [HEX_OUT+BX], DL
    RET

    CORRECTION:
        SUB DL, 9
        OR DL, 0X40
        MOV [HEX_OUT+BX], DL
    RET

    ; STRINGS
    HELLO: DB 'HELLO', 0
    HEX_OUT: DB '0X0000', 0
    
    ; PAD BOOT SECTOR (512 BYTES) WITH 0
    TIMES 510-($-$$) DB 0

    ; END OF BOOT SECTOR INDICATOR
    DW 0XAA55
