# UpdateOS Kernel (UpOS)

README em [Português🇧🇷🇧🇷🇧🇷](https://github.com/EduDaviDev/UpdateOS-Kernel/blob/main/README.ptbr.md) <br>
README en [Español🇪🇸🇪🇸🇪🇸](https://github.com/EduDaviDev/UpdateOS-Kernel/blob/main/README.es.md)<br>

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
