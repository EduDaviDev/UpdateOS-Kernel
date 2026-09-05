# UpdateOS Kernel (UpOS)

README in [English🇺🇸🇺🇸🇺🇸](https://github.com/EduDaviDev/UpdateOS-Kernel/blob/main/README.md) <br>
README en [Español🇪🇸🇪🇸🇪🇸](https://github.com/EduDaviDev/UpdateOS-Kernel/blob/main/README.es.md)<br>

Kernel simples para o sistema operacional UpdateOS, com suporte a saída de texto em modo VGA.  
Exibe "Hello, World!" na inicialização.

## Compilação

Certifique-se de ter as ferramentas necessárias:
- `nasm`
- `gcc` (com suporte a `-m32`)
- `ld`
- `grub-mkrescue` (para gerar ISO)
- `qemu-system-i386` (para execução)

Para compilar tudo (kernel + ISO) e executar:

```bash
make
```
ou
```bash
make all
```

Apenas o kernel (sem ISO):

```bash
make kernel
