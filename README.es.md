# Kernel de UpdateOS (UpOS)

README em [Português🇧🇷🇧🇷🇧🇷](https://github.com/EduDaviDev/UpdateOS-Kernel/blob/main/README.ptbr.md) <br>
README in [English🇺🇸🇺🇸🇺🇸](https://github.com/EduDaviDev/UpdateOS-Kernel/blob/main/README.md) <br>

Kernel sencillo para el sistema operativo UpdateOS, con soporte para salida de texto VGA.

Muestra "Hello World" al iniciar.

## Compilación

Asegúrate de tener las herramientas necesarias:
- `nasm`
- `gcc` (con soporte para `-m32`)
- `ld`
- `grub-mkrescue` (para generar la ISO)
- `qemu-system-i386` (para la ejecución)

Para compilar todo (kernel + ISO) y ejecutar:

```bash
make
```
o
```bash
make all
```

Solo kernel (sin ISO):

```bash.make kernel
