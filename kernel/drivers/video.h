#ifndef VIDEO_H
#define VIDEO_H

#include <stdint.h>

// Funções de saída de texto
void txt_clear();
void txt_putc(char c);
void txt_print(const char *str);
void txt_pos_putc(int x, int y, char c);
void txt_pos_print(int x, int y, const char *str);

#endif