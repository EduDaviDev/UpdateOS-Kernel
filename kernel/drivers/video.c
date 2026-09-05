#include "video.h"
#include "../io.h" // apenas para referência (não usado aqui)

// VGA modo texto: 80 colunas, 25 linhas, memória em 0xB8000
#define VGA_ADDR 0xB8000
#define VGA_COLS 80
#define VGA_ROWS 25
#define VGA_ATTR 0x0F   // atributo: branco sobre preto

static uint16_t *video_mem = (uint16_t *)VGA_ADDR;
static int cursor_x = 0;
static int cursor_y = 0;

// Move o cursor para a posição (x, y)
static void move_cursor(int x, int y) {
    cursor_x = x;
    cursor_y = y;
}

// Escreve um caractere com atributo na posição atual
static void put_char_at_cursor(char c) {
    if (c == '\n') {
        cursor_x = 0;
        cursor_y++;
        if (cursor_y >= VGA_ROWS) {
            // Rolagem simples (opcional)
            cursor_y = VGA_ROWS - 1;
        }
        return;
    }

    uint16_t entry = (uint16_t)c | (VGA_ATTR << 8);
    video_mem[cursor_y * VGA_COLS + cursor_x] = entry;
    cursor_x++;
    if (cursor_x >= VGA_COLS) {
        cursor_x = 0;
        cursor_y++;
        if (cursor_y >= VGA_ROWS) {
            cursor_y = VGA_ROWS - 1;
        }
    }
}

void txt_putc(char c) {
    put_char_at_cursor(c);
}

void txt_print(const char *str) {
    while (*str) {
        txt_putc(*str++);
    }
}

void txt_pos_putc(int x, int y, char c) {
    if (x < 0 || x >= VGA_COLS || y < 0 || y >= VGA_ROWS)
        return;
    uint16_t entry = (uint16_t)c | (VGA_ATTR << 8);
    video_mem[y * VGA_COLS + x] = entry;
}

void txt_pos_print(int x, int y, const char *str) {
    if (x < 0 || x >= VGA_COLS || y < 0 || y >= VGA_ROWS)
        return;
    while (*str && x < VGA_COLS) {
        video_mem[y * VGA_COLS + x] = (uint16_t)*str | (VGA_ATTR << 8);
        str++;
        x++;
    }
}

void txt_clear() {
	for (int y = 0; y < VGA_ROWS; y++) {
		for (int x = 0; x < VGA_COLS; x++) {
			video_mem[y * VGA_COLS + x] = (uint16_t)' ' | (VGA_ATTR << 8);
		}
	}
	move_cursor(0, 0);
}