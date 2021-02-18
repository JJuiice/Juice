; Copyright (c) 2021 Ojas Anand.
;
; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation;
; either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
; You should have received a copy of the GNU General Public License along with this program. If not, see https://www.gnu.org/licenses/. 


   SECTION .TEXT
GLOBAL _START

_START:
    ; REMEMBER THAT BOOTLOADER IS LOADED AT PRESENT ADDRESS
    [ORG 0x7C00]

    JMP REAL_START
   
    ; MOV [BOOT_DRV], DL     ; REMEMBER BOOT DRIVE STORED IN DL FOR LATER
    ; MOV BX, 0x9000         ; LOAD 5 SECTORS TO 0x0000(ES):0x9000(BX)
    ; MOV DH, 5              ; FROM BOOT DISK
    ; MOV DL, [BOOT_DRV]     ; LOAD BOOT DRIVE TO DL 
    ; CALL DSK_LD            ; CALL DISK LOAD FUNCTION
    
    ; PRINT FIRST LOADED WORD (0xDADA)
    ; MOV AX, [0x9000]
    ; CALL PRNT_HEX
    
    ; PRINT FIRST WORD FROM SECOND LOADED SECTOR
    ; MOV AX, [0x9000 + 512]
    ; CALL PRNT_HEX

    JMP $   ; INFINITE LOOP

    %include "gdt.asm"
    %include "io_funcs.asm"
    %include "real_mode.asm"
    %include "prot_mode.asm"
 
    ; BOOT SECTOR PADDING AND END INDICATOR 
    TIMES 510-($-$$) DB 0
    DW 0xAA55

    ; TEST DISK LOAD
    ; TIMES 256 DW 0xDADA
    ; TIMES 256 DW 0xFACE
