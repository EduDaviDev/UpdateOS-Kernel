/* kernel/linker.ld - Script de ligação para o UpOS Kernel */

OUTPUT_FORMAT(elf32-i386)
ENTRY(start)

SECTIONS
{
    /* Endereço de carga padrão para kernels Multiboot */
    . = 0x100000;

    /* Seção do cabeçalho Multiboot - DEVE vir primeiro */
    .multiboot : {
        *(.multiboot)
    }

    /* Seção de código */
    .text : {
        *(.text)
    }

    /* Seção de dados inicializados */
    .data : {
        *(.data)
    }

    /* Seção BSS (dados não inicializados) */
    .bss : {
        *(.bss)
    }

    /* Seção de debug (opcional) */
    /DISCARD/ : {
        *(.comment)
        *(.note)
    }
}