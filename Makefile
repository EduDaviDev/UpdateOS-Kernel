# ============================================================================
# Makefile para kernel UPK
# Alvo: all, system, kernel, iso, run, clean
# ============================================================================

# --------------------------------------
# Ferramentas
# --------------------------------------
CC      := gcc
CXX     := g++
AS      := as
LD      := ld
NASM    := nasm
QEMU    := qemu-system-i386

# --------------------------------------
# Flags
# --------------------------------------
CFLAGS   := -m32 -ffreestanding -nostdlib -I. -Wall -Wextra -g
CXXFLAGS := -m32 -ffreestanding -nostdlib -fno-exceptions -fno-rtti -I. -Wall -Wextra -g
ASFLAGS  := -m32
LDFLAGS  := -m elf_i386 -T kernel/linker.ld -nostdlib

# --------------------------------------
# Localização dos fontes
# --------------------------------------
SOURCES_C   := $(shell find kernel -type f -name "*.c")
SOURCES_CPP := $(shell find kernel -type f \( -name "*.cpp" -o -name "*.c++" -o -name "*.cc" \))
SOURCES_ASM := $(shell find kernel -type f -name "*.asm")
SOURCES_S   := $(shell find kernel -type f -name "*.s")

# --------------------------------------
# Objectos (mantêm estrutura de diretórios)
# --------------------------------------
OBJS_C   := $(addsuffix .o, $(basename $(subst kernel/,build/kernel/objs/,$(SOURCES_C))))
OBJS_CPP := $(addsuffix .o, $(basename $(subst kernel/,build/kernel/objs/,$(SOURCES_CPP))))
OBJS_ASM := $(addsuffix .o, $(basename $(subst kernel/,build/kernel/objs/,$(SOURCES_ASM))))
OBJS_S   := $(addsuffix .o, $(basename $(subst kernel/,build/kernel/objs/,$(SOURCES_S))))

OBJS := $(OBJS_C) $(OBJS_CPP) $(OBJS_ASM) $(OBJS_S)

OS := WSL

ifeq ($(OS), WSL)
	CMD := cmd.exe /C "
	CMDEND := "
else ifeq ($(OS), Linux)
	CMD :=
	CMDEND :=
endif

# --------------------------------------
# Alvos principais
# --------------------------------------
.PHONY: all system kernel iso run clean

all: system

system: kernel iso run

# --------------------------------------
# kernel : compila e coloca o binário na ISO
# --------------------------------------
kernel: build/iso/boot/grub/kernel.bin

# A cópia é feita na regra que gera o .bin dentro da ISO
build/iso/boot/grub/kernel.bin: build/upknel.bin
	@mkdir -p $(dir $@)
	cp $< $@

# Linkagem final do kernel
build/upknel.bin: $(OBJS) kernel/linker.ld
	@mkdir -p $(dir $@)
	$(LD) $(LDFLAGS) -o $@ $(OBJS)

# --------------------------------------
# iso : gera a imagem ISO
# --------------------------------------
iso: build/system.iso

build/system.iso: build/iso/boot/grub/kernel.bin
	@echo "Copiando arquivos da ISO..."
	cp -r kernel/iso/. build/iso/system/
	cp build/upknel.bin build/iso/boot/kernel.bin
	cp kernel/grub.cfg build/iso/boot/grub/grub.cfg
	@echo "Gerando ISO com grub-mkrescue..."
	grub-mkrescue -o $@ build/iso

# --------------------------------------
# run : executa no QEMU
# --------------------------------------
run: iso
	@mkdir -p logs
	$(CMD)$(QEMU) -cdrom build/system.iso \
		-serial file:logs/serial.log \
		-D logs/qemu.log -d int \
		-no-reboot -no-shutdown$(CMDEND)

# --------------------------------------
# Regras de compilação
# --------------------------------------
# C
build/kernel/objs/%.o: kernel/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# C++ (.cpp)
build/kernel/objs/%.o: kernel/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# C++ (.c++)
build/kernel/objs/%.o: kernel/%.c++
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# C++ (.cc)
build/kernel/objs/%.o: kernel/%.cc
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Assembly NASM
build/kernel/objs/%.o: kernel/%.asm
	@mkdir -p $(dir $@)
	$(NASM) -f elf32 -o $@ $<

# Assembly GAS
build/kernel/objs/%.o: kernel/%.s
	@mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) -o $@ $<

# --------------------------------------
# Limpeza
# --------------------------------------
clean:
	rm -rf build logs