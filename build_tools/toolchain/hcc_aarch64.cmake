cmake_minimum_required(VERSION 3.14.1)

set(arch "aarch64")
set(compiler_prefix "aarch64-target-linux-gnu-")
set(compiler_path "/opt/buildtools/bisheng_cpu-3.1.0.b015/hcc_arm64le/bin")

# cross compiler setup
set(full_compiler_prefix "${compiler_path}/${compiler_prefix}")
set(CMAKE_C_OUTPUT_EXTENSION_REPLACE 1)
set(CMAKE_ASM_OUTPUT_EXTENSION_REPLACE 1)
set(CMAKE_C_COMPILER "${full_compiler_prefix}gcc")
set(CMAKE_ASM_COMPILER "${full_compiler_prefix}gcc")
set(CMAKE_CXX_COMPILER "${full_compiler_prefix}g++")
set(CMAKE_AR "${full_compiler_prefix}ar")
set(CMAKE_OBJCOPY "${full_compiler_prefix}objcopy")
