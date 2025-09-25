TARGET = stm32_project

CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
OBJCOPY = arm-none-eabi-objcopy
SIZE = arm-none-eabi-size

CFLAGS = -mcpu=cortex-m0plus -mthumb -g -Wall -O0 \
	-Iinclude \
	-Iinclude/cmsis_core \
	-DSTM32L053xx
ASFLAGS = -mcpu=cortex-m0plus -mthumb

BUILD = build
SRC = src
FREERTOS_SRC = FreeRTOS
STARTUP = startup
LINKER = linker/stm32l053r8.ld

OBJECTS = \
	$(BUILD)/startup_stm32l053xx.o \
    $(BUILD)/system_stm32l0xx.o \
    $(BUILD)/main.o

all: $(BUILD)/$(TARGET).elf

$(BUILD)/$(TARGET).elf: $(OBJECTS)
	$(CC) $(CFLAGS) $^ -T$(LINKER) -nostartfiles -o $@
	$(OBJCOPY) -O binary $@ $(BUILD)/$(TARGET).bin
	$(SIZE) $@

$(BUILD)/system_stm32l0xx.o: $(SRC)/system_stm32l0xx.c
	mkdir -p $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD)/main.o: $(SRC)/main.c
	mkdir -p $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD)/startup_stm32l053xx.o: $(STARTUP)/startup_stm32l053xx.s
	mkdir -p $(BUILD)
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -rf $(BUILD)

st-flash: $(BUILD)/$(TARGET).bin
	st-flash write $< 0x8000000


