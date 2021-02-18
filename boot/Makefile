# Copyright (c) 2021 Ojas Anand.
#
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation;
# either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program. If not, see https://www.gnu.org/licenses/.

BOOT_BIN=boot
BOOT_DEPS=main.asm prot_mode.asm io_funcs.asm gdt.asm

all: $(BOOT_BIN).img

clean: $(BOOT_BIN).img
	rm $^

$(BOOT_BIN).img: $(BOOT_DEPS)
	nasm main.asm -f bin -o $@
