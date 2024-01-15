.code16

// header of the multiboot 1 specification
// https://www.gnu.org/software/grub/manual/multiboot/multiboot.html#Boot-sources
multiboot_header:

    // align at 32 bits boundary
    .align 4

    // multiboot header magic value
    .long 0x1BADB002

    // multiboot header flags
    // this sets the MULTIBOOT_ALIGN and MULTIBOOT_MEMINFO flags
    // 0b1 | 0b10 = 0b11
    .long 0x00000003

    // multiboot header checksum
    // this should be equal to -(magic + flags)
    .long -0x1BADB005

// start of the bss segment
// TODO: move this to linker script
.section .bss
    // align at 16 bits boundary
    .align 16

// reserve 16KB of memory for stack
// TODO: move this to linker script
stack_bottom:
    .skip 16384
stack_top:

// start of the text segment
.section .text

.global _start
.extern kmain

// set the CPU instruction mode to protected mode
// as the grub have now changed the CPU to 32 bit mode
.code32
_start:

    // set up the stack
    mov $stack_top, %esp
    mov $stack_top, %ebp

    // entrypoint of our kernel
    // kernel's main function will not return
    call kmain

    // this should never happen
    cli
    hlt
    jmp .

