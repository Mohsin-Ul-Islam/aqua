// this sets the instruction mode for 16 real mode
.code16

// start symbol
_start:

// loop indefinitely
jmp _start

// pad the remaining boot sector with
// this is because the boot sector should be a
// total of 512 bytes long
.fill 510 - (. - _start), 1, 0

// the final two bytes are boot sector's magic value
.word 0xaa55
