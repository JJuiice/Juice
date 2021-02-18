; Copyright (c) 2021 Ojas Anand.
;
; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation;
; either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
; You should have received a copy of the GNU General Public License along with this program. If not, see https://www.gnu.org/licenses/. 


REAL_START:
; OPERATE IN 16-BIT REAL MODE
[BITS 16]

; SET STACK TO SLIGHTLY ABOVE END OF BOOT SECTOR AS IT GROWS DOWNWARDS
; STACK SIZE = 0x8000 - (0x7C00 + 0x01FF)
MOV BP, 0x8000
MOV SP, BP

MOV SI, REAL_MODE_MSG
CALL PRNT_STR 

SWTCH_TO_PM:
CLI

LGDT [GDT_DESCRIPTOR]

MOV EAX, CR0
OR EAX, 0x1
MOV CR0, EAX

JMP TEXT_SEG:INIT_PM

; VARS
REAL_MODE_MSG: DB 'STARTED IN 16-BIT REAL MODE', 0

REAL_END:
