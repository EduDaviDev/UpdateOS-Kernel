# UpdateOS Kernel (UpOS)

README em Português🇧🇷🇧🇷🇧🇷: 
README in English🇺🇸🇺🇸🇺🇸: 
README en Español🇪🇸🇪🇸🇪🇸: 

A simple kernel for the UpdateOS operating system, featuring VGA-mode text output support.
Displays "Hello, World!" upon startup.

## Compilation

Ensure you have the necessary tools installed:
- `nasm`
- `gcc` (with `-m32` support)
- `ld`
- `grub-mkrescue` (to generate the ISO)
- `qemu-system-i386` (for execution)

To compile everything (kernel + ISO) and run:

```bash
make
```
or
```bash
make all
```

Kernel only (without ISO):

```bash
make kernel
```