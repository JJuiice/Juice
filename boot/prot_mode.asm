; Copyright (c) 2021 Ojas Anand.
;
; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation;
; either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
; You should have received a copy of the GNU General Public License along with this program. If not, see https://www.gnu.org/licenses/. 


PM_START:
[BITS 32]

INIT_PM:
MOV AX, DATA_SEG
MOV DS, AX
MOV SS, AX
MOV ES, AX
MOV FS, AX
MOV GS, AX

MOV EBP, 0x80000
MOV ESP, EBP

MOV ESI, PROT_MODE_MSG
CALL PRNT_STR_PM
JMP $

PROT_MODE_MSG: DB 'SUCCESSFULLY SWITCHED TO 32-BIT PROTECTED MODE', 0

PM_END:
