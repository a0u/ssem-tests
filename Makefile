target := ssem-unknown-elf
tests := hcf hcf_k hcf_t div

AS := $(target)-as
LD := $(target)-ld
OBJDUMP := $(target)-objdump
OBJCOPY := $(target)-objcopy

.PHONY: all hex dump
all: hex dump
hex: $(addsuffix .hex,$(tests))
dump: $(addsuffix .dump,$(tests))

.SUFFIXES:
.SUFFIXES: .S .o .elf .bin .hex .dump
.PRECIOUS: %.o %.elf %.bin

.S.o:
	$(AS) -o $@ $<

.o.elf:
	$(LD) -o $@ $<

.elf.dump:
	$(OBJDUMP) -D $< > $@

.elf.bin:
	$(OBJCOPY) -S -O binary $< $@

# TODO: Handle mismatched host endianness
.bin.hex:
	od -A n -t x4 -v $< | tr -s '[[:space:]]' '\n' | tail -n +2 > $@

.PHONY: clean
clean:
	rm -f -- *.o *.elf *.bin *.hex *.dump
