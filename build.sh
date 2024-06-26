#!/bin/bash
set -e

cmake -S . -Bbuild -DCMAKE_INSTALL_PREFIX="output" -DCMAKE_TOOLCHAIN_FILE="build_tools/toolchain/hcc_aarch64.cmake"
(cd build && make install -j)
cp output/boot/boot.img /mnt/c/A/Firmware/op5p/
