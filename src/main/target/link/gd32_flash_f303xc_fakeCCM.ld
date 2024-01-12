/*
*****************************************************************************
**
**  File        : gd32_flash_f303xc.ld
**
**  Abstract    : Linker script forGD32F30x Device with
**                256KByte FLASH and 48KByte RAM
**
*****************************************************************************
*/

/* Stack & Heap sizes */
_Min_Heap_Size = 0;
_Min_Stack_Size = 0x1800;

/* Specify the memory areas. */
MEMORY
{
    /*FLASH (rx)        : ORIGIN = 0x08000000, LENGTH = 255K*/
    /*FLASH_CONFIG (r)  : ORIGIN = 0x0803FC00, LENGTH = 1K*/
    FLASH (rx)        : ORIGIN = 0x08000000, LENGTH = 248K
    FLASH_CONFIG (r)  : ORIGIN = 0x0803E000, LENGTH = 8K

    /*RAM (xrw)         : ORIGIN = 0x20000000, LENGTH = 40K*/
    /*CCM (xrw)         : ORIGIN = 0x10000000, LENGTH = 8K*/
    RAM (xrw)         : ORIGIN = 0x20000000, LENGTH = 40K
    CCM (xrw)         : ORIGIN = 0x2000A000, LENGTH = 8K
    MEMORY_B1 (rx)    : ORIGIN = 0x60000000, LENGTH = 0K
}

REGION_ALIAS("STACKRAM", CCM)
REGION_ALIAS("FASTRAM", CCM)

INCLUDE "gd32_flash.ld"
