# UpdateOS Kernel (UpOS)

README em Português🇧🇷🇧🇷🇧🇷: 
README in English🇺🇸🇺🇸🇺🇸: 
README en Español🇪🇸🇪🇸🇪🇸: 

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