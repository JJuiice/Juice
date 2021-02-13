BOOT=boot

all: $(BOOT).img

clean: $(BOOT).img
	rm $^

%.img: %.asm
	nasm $^ -f bin -o $@
