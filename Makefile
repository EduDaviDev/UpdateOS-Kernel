# Makefile para UpOS Kernel
# Uso: make [all|clean|run|iso]
# Variável TERMINAL: UBUNTU (execução direta) ou WSL (via cmd.exe com logs)

ASM = nasm
CC = gcc
LD = ld
CFLAGS = -m32 -ffreestanding -nostdlib -fno-pie -fno-stack-protector -Wall -Wextra -I./kernel/drivers
LDFLAGS = -m elf_i386 -Ttext 0x100000 -nostdlib

# Diretórios
SRC_DIR = kernel
DRV_DIR = $(SRC_DIR)/drivers
BUILD_DIR = build
OBJ_DIR = $(BUILD_DIR)/kernel/objs
ISO_DIR = $(BUILD_DIR)/iso
BOOT_DIR = $(ISO_DIR)/boot
GRUB_DIR = $(BOOT_DIR)/grub

# Arquivos fontes
C_SRCS = $(shell find $(SRC_DIR) -type f -name '*.c')
ASM_SRCS = $(shell find $(SRC_DIR) -type f -name '*.asm')
S_SRCS = $(shell find $(SRC_DIR) -type f -name '*.s')

# Objetos correspondentes (substituindo caminhos e extensões)
C_OBJS = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(C_SRCS))
ASM_OBJS = $(patsubst $(SRC_DIR)/%.asm, $(OBJ_DIR)/%.o, $(ASM_SRCS))
S_OBJS = $(patsubst $(SRC_DIR)/%.s, $(OBJ_DIR)/%.o, $(S_SRCS))
OBJS = $(C_OBJS) $(ASM_OBJS) $(S_OBJS)

# Arquivos finais
KERNEL_BIN = $(BUILD_DIR)/kernel.bin
ISO_IMAGE = $(BUILD_DIR)/upos.iso

# Padrão: WSL
TERMINAL ?= WSL

.PHONY: all clean run iso

all: $(ISO_IMAGE)

# Gerar ISO (depende do kernel.bin e do grub.cfg)
$(ISO_IMAGE): $(KERNEL_BIN) $(SRC_DIR)/grub.cfg
	@mkdir -p $(GRUB_DIR)
	cp $(KERNEL_BIN) $(BOOT_DIR)/
	cp $(SRC_DIR)/grub.cfg $(GRUB_DIR)/
	grub-mkrescue -o $@ $(ISO_DIR)

# Linkar o kernel
$(KERNEL_BIN): $(OBJS)
	@mkdir -p $(BUILD_DIR)
	$(LD) $(LDFLAGS) -o $@ $^

# Compilar arquivos C
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Compilar arquivos .asm (NASM)
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.asm
	@mkdir -p $(dir $@)
	$(ASM) -f elf32 $< -o $@

# Compilar arquivos .s (GAS)
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Executar (depende do ISO para WSL, do kernel.bin para UBUNTU)
run: $(KERNEL_BIN) $(ISO_IMAGE)
ifeq ($(TERMINAL),UBUNTU)
	qemu-system-i386 -cdrom $(ISO_IMAGE) -boot d -serial file:logs/serial.log -D logs/qemu.log
else
	# WSL: executar via cmd.exe com logs
	@mkdir -p logs
	cmd.exe /c "qemu-system-i386 -cdrom $(ISO_IMAGE) -boot d -serial file:logs/serial.log -D logs/qemu.log"
endif

# Limpeza
clean:
	rm -rf $(BUILD_DIR) logs

# Regra auxiliar para apenas o kernel (sem ISO)
kernel: $(KERNEL_BIN)