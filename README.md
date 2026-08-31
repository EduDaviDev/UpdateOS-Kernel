# UpdateOS Kernel (UpOS)

Kernel simples para o sistema operacional UpdateOS, com suporte a saída de texto em modo VGA.  
Exibe "Hello, World!" na inicialização.

## Estrutura do Projeto
UpOS/
├── Makefile
├── .gitignore
├── README.md
├── kernel/
│ ├── kernel.c
│ ├── io.h
│ ├── grub.cfg
│ ├── mboot.asm
│ └── drivers/
│ ├── video.c
│ └── video.h
├── build/ (criado na compilação)
│ ├── kernel.bin
│ ├── upos.iso
│ └── kernel/objs/ (objetos intermediários)
└── logs/ (criado na execução WSL)
├── serial.log
└── qemu.log

## Compilação

Certifique-se de ter as ferramentas necessárias:
- `nasm`
- `gcc` (com suporte a `-m32`)
- `ld`
- `grub-mkrescue` (para gerar ISO)
- `qemu-system-i386` (para execução)

Para compilar tudo (kernel + ISO):

```bash
make
```

Apenas o kernel (sem ISO):

```bash
make kernel