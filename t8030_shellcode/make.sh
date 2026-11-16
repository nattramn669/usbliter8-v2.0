#!/bin/bash

set -e

mkdir -p build

build_shellcode() {
    target="$1"
    shift

    clang -arch arm64 -Os -Wl,-preload -Wl,-segalign,0x10 \
        -Wl,-order_file,symorder.txt -nostdlib -fno-vectorize "$@" \
        start.S patch.c tt.c -o "build/shellcode_$target.o"
    vmacho -f "build/shellcode_$target.o" "build/shellcode_$target.bin"

    echo -n "const " > "../resources/shellcode_$target.h"
    xxd -i -n "shellcode_$target" "build/shellcode_$target.bin" \
        >> "../resources/shellcode_$target.h"
}

# Keep resources/shellcode_t8030.h byte-for-byte as supplied by the upstream
# 1.0 build. This local toolchain does not reproduce that legacy blob exactly.
build_shellcode t8030_ipad9 -DT8030_IPAD9_PROFILE=1
