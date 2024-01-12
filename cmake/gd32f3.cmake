include(cortex-m4f)
include(gd32-stdperiph)
include(gd32f3-usb)

set(GD32F3_STDPERIPH_DIR "${MAIN_LIB_DIR}/main/STM32F3/Drivers/STM32F30x_StdPeriph_Driver")
set(GD32F3_CMSIS_DEVICE_DIR "${MAIN_LIB_DIR}/main/STM32F3/Drivers/CMSIS/Device/ST/STM32F30x")
set(GD32F3_CMSIS_DRIVERS_DIR "${MAIN_LIB_DIR}/main/STM32F3/Drivers/CMSIS")
set(GD32F3_VCP_DIR "${MAIN_SRC_DIR}/vcp")

set(GD32F3_STDPERIPH_SRC_EXCLUDES
    stm32f30x_crc.c
    stm32f30x_can.c
)
set(GD32F3_STDPERIPH_SRC_DIR "${GD32F3_STDPERIPH_DIR}/src")
glob_except(GD32F3_STDPERIPH_SRC "${GD32F3_STDPERIPH_SRC_DIR}/*.c" "${GD32F3_STDPERIPH_SRC_EXCLUDES}")


main_sources(GD32F3_SRC
    target/system_stm32f30x.c

    config/config_streamer_stm32f3.c
    config/config_streamer_ram.c
    config/config_streamer_extflash.c

    drivers/adc_stm32f30x.c
    drivers/bus_i2c_stm32f30x.c
    drivers/dma_stm32f3xx.c
    drivers/serial_uart_stm32f30x.c
    drivers/system_stm32f30x.c
    drivers/timer_impl_stdperiph.c
    drivers/timer_stm32f30x.c
)

set(GD32F3_VCP_SRC
    hw_config.c
    stm32_it.c
    usb_desc.c
    usb_endp.c
    usb_istr.c
    usb_prop.c
    usb_pwr.c
)
list(TRANSFORM GD32F3_VCP_SRC PREPEND "${GD32F3_VCP_DIR}/")

set(GD32F3_INCLUDE_DIRS
    "${CMSIS_INCLUDE_DIR}"
    "${CMSIS_DSP_INCLUDE_DIR}"
    "${GD32F3_STDPERIPH_DIR}/inc"
    "${GD32F3_CMSIS_DEVICE_DIR}"
    "${GD32F3_CMSIS_DRIVERS_DIR}"
    "${GD32F3_VCP_DIR}"
)

set(GD32F3_DEFINITIONS
    ${CORTEX_M4F_DEFINITIONS}
    GD32F3
    USE_STDPERIPH_DRIVER
)

set(GD32F303CC_DEFINITIONS
    GD32F303
    GD32F303xC
    MCU_FLASH_SIZE=256
)

set(GD32F303CE_DEFINITIONS
    GD32F303
    GD32F303xE
    MCU_FLASH_SIZE=512
)

set(GD32F303CG_DEFINITIONS
    GD32F303
    GD32F303xG
    MCU_FLASH_SIZE=1024
)

function(target_gd32f3xx)
    # F3 targets don't support MSC and use -Os instead of -O2 to save size
    target_gd32(
        SOURCES ${GD32_STDPERIPH_SRC} ${GD32F3_STDPERIPH_SRC} ${GD32F3_SRC}
        COMPILE_DEFINITIONS ${GD32F3_DEFINITIONS}
        COMPILE_OPTIONS ${CORTEX_M4F_COMMON_OPTIONS} ${CORTEX_M4F_COMPILE_OPTIONS}
        INCLUDE_DIRECTORIES ${GD32F3_INCLUDE_DIRS}
        LINK_OPTIONS ${CORTEX_M4F_COMMON_OPTIONS} ${CORTEX_M4F_LINK_OPTIONS}

        VCP_SOURCES ${GD32F3_USB_SRC} ${GD32F3_VCP_SRC}
        VCP_INCLUDE_DIRECTORIES ${GD32F3_USB_INCLUDE_DIRS}

        DISABLE_MSC

        OPTIMIZATION -Os

        OPENOCD_TARGET gd32f3x

        ${ARGN}
    )
endfunction()

function(target_gd32f303xc name)
    target_gd32f3xx(
        NAME ${name}
        STARTUP startup_gd32f30x_md_gcc.S
        COMPILE_DEFINITIONS ${GD32F303CC_DEFINITIONS}
        LINKER_SCRIPT gd32_flash_f303xc
        SVD STM32F303
        ${ARGN}
    )
endfunction()

function(target_gd32f303xc_noCCM name)
    target_gd32f3xx(
        NAME ${name}
        STARTUP startup_gd32f30x_md_gcc.S
        COMPILE_DEFINITIONS ${GD32F303CC_DEFINITIONS}
        LINKER_SCRIPT gd32_flash_f303xc_noCCM
        SVD STM32F303
        ${ARGN}
    )
endfunction()

function(target_gd32f303xc_fakeCCM name)
    target_gd32f3xx(
        NAME ${name}
        STARTUP startup_gd32f30x_md_gcc.S
        COMPILE_DEFINITIONS ${GD32F303CC_DEFINITIONS}
        LINKER_SCRIPT gd32_flash_f303xc_fakeCCM
        SVD STM32F303
        ${ARGN}
    )
endfunction()

function(target_gd32f303xe name)
    target_gd32f3xx(
        NAME ${name}
        STARTUP startup_gd32f30x_md_gcc.S
        COMPILE_DEFINITIONS ${GD32F303CE_DEFINITIONS}
        LINKER_SCRIPT gd32_flash_f303xe
        SVD STM32F303
        ${ARGN}
    )
endfunction()

function(target_gd32f303xg name)
    target_gd32f3xx(
        NAME ${name}
        STARTUP startup_gd32f30x_md_gcc.S
        COMPILE_DEFINITIONS ${GD32F303CG_DEFINITIONS}
        LINKER_SCRIPT gd32_flash_f303xg
        SVD STM32F303
        ${ARGN}
    )
endfunction()
