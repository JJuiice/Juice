REM Copyright (c) 2021 Ojas Anand.
REM
REM This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation;
REM either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
REM without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
REM You should have received a copy of the GNU General Public License along with this program. If not, see https://www.gnu.org/licenses/

qemu-system-x86_64 -L "C:\Program Files\qemu" -blockdev driver=file,node-name=f0,filename=D:\Users\Standard\Documents\Juice\boot\boot.img -device floppy,drive=f0
