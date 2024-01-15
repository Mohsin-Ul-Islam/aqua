boot.o: arch/i686/boot/boot.s
	i686-elf-as -o $@ $<

boot.bin: boot.o
	i686-elf-ld -Ttext=0x7c00 --oformat binary -o $@ $^

multiboot.o: arch/i686/boot/multiboot.s
	i686-elf-as -o $@ $<

kernel.o: kernel/kernel.c kernel/kernel.h
	i686-elf-gcc -ffreestanding -m32 -o $@ -c $< -I kernel/kernel.h

os.bin: multiboot.o kernel.o
	i686-elf-ld -Ttext=0x10000 -o $@ $^

os.iso: os.bin arch/i686/boot/grub.cfg
	mkdir -p iso/boot/grub && cp $^ iso/boot/grub && grub-mkrescue -o $@ iso

run: os.iso
	qemu-system-i386 -cdrom os.iso

clean:
	rm -r iso *.bin *.o *.iso

