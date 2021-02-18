; Copyright (c) 2021 Ojas Anand.
;
; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation;
; either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
; You should have received a copy of the GNU General Public License along with this program. If not, see https://www.gnu.org/licenses/. 


GDT_START:

; GDT MUST BEGIN WITH 8 NULL BYTES
GDT_NULL:
DD 0x0
DD 0x0

; CODE SEGMENT DESCRIPTOR
GDT_TEXT:
DW 0xFFFF       ; LIMIT[15:0] (15:0)
DW 0x0          ; BASE[15:0] (31:16)
DB 0X0          ; BASE[23:16] (39:32)
DB 10011010b    ; TYPE FLAGS (47:40)
DB 11001111b    ; REMANING FLAGS; LIMIT[19:16] (55:48)
DB 0x0          ; BASE[31:24] (63:56)

; DATA SEGMENT DESCRIPTOR
GDT_DATA:
DW 0xFFFF       ; LIMIT[15:0] (15:0)
DW 0x0          ; BASE[15:0] (31:16)
DB 0X0          ; BASE[23:16] (39:32)
DB 10010010b    ; 1st FLAGS; TYPE FLAGS (47:40)
DB 11001111b    ; 2nd FLAGS; LIMIT[19:16] (55:48)
DB 0x0          ; BASE[31:24] (63:56)

GDT_END:

GDT_DESCRIPTOR:
DW GDT_END - GDT_START - 1  ; GDT SIZE - 1
DD GDT_START                ; START ADDRESS OF OUR GDT 

; SEGEMENTS OF GDT
TEXT_SEG equ GDT_TEXT - GDT_START
DATA_SEG equ GDT_DATA - GDT_START
