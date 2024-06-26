cmake_minimum_required(VERSION 3.25)
project(op5p C ASM)

message("Toolchain: ${CMAKE_TOOLCHAIN_FILE}")

add_compile_options(
    -nostdlib -nostdinc -fPIC
    -fpic -fno-builtin -freg-struct-return -funsigned-char
    -ffunction-sections -fdata-sections -fno-short-enums
    -fno-exceptions -pipe -fno-aggressive-loop-optimizations
    -Wall -Werror -Wformat=2  -Wstrict-prototypes -Winvalid-pch
    -nostdinc -nostdlib -g -gdwarf-2 -O2 -std=c99 -DUDK_AARCH64
    -mcpu=cortex-a53
)

add_link_options(
    -nostdlib -Wl,--gc-sections -Wl,--build-id=none
)

include_directories(include)

add_subdirectory(boot)

install(
    DIRECTORY "${CMAKE_BINARY_DIR}/"
    DESTINATION "./"
    FILES_MATCHING
        PATTERN "*.so"
        PATTERN "*.a"
        PATTERN "*.elf"
        PATTERN "*.bin"
        PATTERN "*.img"
        PATTERN "CMakeFiles" EXCLUDE
)
