ENTRY(Reset_Handler)

MEMORY
{
  FLASH (rx)  : ORIGIN = 0x08000000, LENGTH = 64K
  RAM   (xrw) : ORIGIN = 0x20000000, LENGTH = 8K
}

_estack = ORIGIN(RAM) + LENGTH(RAM);

SECTIONS
{
  .isr_vector :
  {
      . = ALIGN(4);
      KEEP(*(.vector_table))
      . = ALIGN(4);
  } > FLASH

  .text :
  {
      . = ALIGN(4);
      *(.text*)
      . = ALIGN(4);
  } > FLASH

  .rodata :
  {
      . = ALIGN(4);
      *(.rodata*)
      . = ALIGN(4);
  } > FLASH

  _sidata = .;

  .data : AT(_sidata)
  {
      . = ALIGN(4);
      _sdata = .;
      *(.data*)
      _edata = .;
      . = ALIGN(4);
  } > RAM

  .bss :
  {
      . = ALIGN(4);
      _sbss = .;
      *(.bss*)
      *(COMMON)
      _ebss = .;
      . = ALIGN(4);
  } > RAM
}