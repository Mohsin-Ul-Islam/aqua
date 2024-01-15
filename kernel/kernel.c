#include <stddef.h>

#include "kernel.h"

// entry point of the kernel
void kmain() {

  char *vga_addr = (char *)VGA_ADDR;
  const char *message = "Hello, World!";

  for (size_t i = 0; i < 13; i++) {
    vga_addr[i * 2] = message[i];
    vga_addr[(i * 2) + 1] = VGA_CLR_WHITE | VGA_CLR_BLACK;
  }

  // kernel's main function will never return
  for (;;) {
  }
}
