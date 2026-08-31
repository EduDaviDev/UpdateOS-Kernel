; mboot.asm - Cabeçalho Multiboot e ponto de entrada

section .multiboot
align 4
    dd 0x1BADB002          ; magic number
    dd 0x03                ; flags (0x03 = alinhamento + memória)
    dd -(0x1BADB002 + 0x03); checksum

section .text
global start
extern kernel_main

start:
    ; Configurar pilha (8KB)
    mov esp, stack_top

    ; Chamar kernel_main (nunca deve retornar)
    call kernel_main

    ; Se retornar, parar a CPU
    cli
    hlt

section .bss
align 16
stack_bottom:
    resb 8192
stack_top: