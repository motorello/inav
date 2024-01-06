set(GD32_USBFS_DIR "${MAIN_LIB_DIR}/main/STM32_USB-FS-Device_Driver")

set(GD32_USBFS_SRC
    usb_core.c
    usb_init.c
    usb_int.c
    usb_mem.c
    usb_regs.c
    usb_sil.c
)
list(TRANSFORM GD32_USBFS_SRC PREPEND "${GD32_USBFS_DIR}/src/")

set(GD32F3_USB_INCLUDE_DIRS
    ${GD32_USBFS_DIR}/inc
)
set(GD32F3_USB_SRC ${GD32_USBFS_SRC})
