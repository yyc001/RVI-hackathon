
CC = gcc
CFLAGS = -Wall -O2

CROSS = riscv64-unknown-elf-
CROSS_CC = $(CROSS)$(CC)
CROSS_CFLAGS = -nostdlib -march=rv32i -mabi=ilp32 -Tcpu_test/link.ld -Wl,--gc-sections -ffreestanding
OBJCOPY = $(CROSS)objcopy
OBJDUMP = $(CROSS)objdump

emu_exe: core/emulator.c core/inst.c core/main.c
	$(CC) $(CFLAGS) -o $@ $^

libcpu: core/emulator.c core/inst.c
	$(CC) $(CFLAGS) -shared -fPIC -o $@.so $^

image: cpu_test/main.c
	$(CROSS_CC) $(CROSS_CFLAGS) -o $@.elf $^
	$(OBJDUMP) -D $@.elf > $@.txt
	$(OBJCOPY) -O binary $@.elf $@.bin

emu_test: emu_exe image.bin
	./emu_exe ./image.bin

clean:
	rm -f emu_* image.*
