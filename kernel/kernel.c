#include "drivers/video.h"

void kernel_main(void) {
    // Inicialização básica (opcional)
    // Escreve "Hello, World!" na tela
    txt_print("Hello, World!");

    // Mantém a CPU ocupada
    while (1);
}