# Bare-metal LED Blinker for STM32L053R8

A simple bare-metal project for STM32L053R8 that toggles an LED without using HAL or RTOS.

## Features
- Works without HAL, direct register access
- Configures GPIOA (pin PA0/PA1) as output
- Infinite loop with delay
- Build system: `makefile`

## Requirements
- Microcontroller: STM32L053xx
- Compiler: `arm-none-eabi-gcc`
- Build system: `makefile`
- Flashing tool: ST-Link

## Project structure
- src/        # Source files (main.c, system_stm32l0xx.c)
- include/    # Header files (defines, prototypes)
- linker/     # Linker scripts (MCU memory description)
- Makefile    # Build system: describes how to compile and link

## How it works
GPIOA0/1 is configured as output, and in the infinite loop it toggles (LED on/off) with a delay.

## Build and Run
```bash
make        # build
make st-flash  # flash via ST-Link
