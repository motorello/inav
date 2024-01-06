/*
*****************************************************************************
**
**  File        : gd32_flash_f303xe.ld
**
**  Abstract    : Linker script forGD32F30x Device with
**                512KByte FLASH and 64KByte RAM
**
*****************************************************************************
*/

/* Stack & Heap sizes */
_Min_Heap_Size = 0;
_Min_Stack_Size = 0x1800;

/* Specify the memory areas. */
MEMORY
{
    FLASH (rx)        : ORIGIN = 0x08000000, LENGTH = 506K
    FLASH_CONFIG (r)  : ORIGIN = 0x0807E800, LENGTH = 6K

    RAM (xrw)         : ORIGIN = 0x20000000, LENGTH = 64K
    /*RAM (xrw)         : ORIGIN = 0x20000000, LENGTH = 48K*/
    CCM (xrw)         : ORIGIN = 0x10000000, LENGTH = 16K
    MEMORY_B1 (rx)    : ORIGIN = 0x60000000, LENGTH = 0K
}

REGION_ALIAS("STACKRAM", CCM)
REGION_ALIAS("FASTRAM", CCM)

INCLUDE "gd32_flash.ld"
