#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_ROOT="${BUILD_ROOT:-$SCRIPT_DIR/build-rp2350}"
OUTPUT_DIR="${OUTPUT_DIR:-$SCRIPT_DIR/artifacts/v2.0-rp2350}"
JOBS="${JOBS:-4}"

: "${PICO_SDK_PATH:?Set PICO_SDK_PATH to your local pico-sdk directory}"
: "${PICO_TOOLCHAIN_PATH:?Set PICO_TOOLCHAIN_PATH to your ARM GNU toolchain directory}"

boards=(
    waveshare_rp2350_usb_a
    waveshare_rp2350_zero
    pimoroni_tiny2350
    pico2
)

mkdir -p "$BUILD_ROOT" "$OUTPUT_DIR"

for board in "${boards[@]}"; do
    build_dir="$BUILD_ROOT/$board"
    output="$OUTPUT_DIR/usbliter8-v2.0-$board.uf2"
    cmake_args=(
        -S "$SCRIPT_DIR"
        -B "$build_dir"
        -DPICO_BOARD="$board"
        -DPICO_SDK_PATH="$PICO_SDK_PATH"
        -DPICO_TOOLCHAIN_PATH="$PICO_TOOLCHAIN_PATH"
    )

    if [[ -n "${PICOTOOL_FETCH_FROM_GIT_PATH:-}" ]]; then
        cmake_args+=("-DPICOTOOL_FETCH_FROM_GIT_PATH=$PICOTOOL_FETCH_FROM_GIT_PATH")
    fi

    printf '\n==> Building %s\n' "$board"
    cmake "${cmake_args[@]}"
    cmake --build "$build_dir" --parallel "$JOBS"
    cp "$build_dir/usbliter8.uf2" "$output"
    printf '    UF2: %s\n' "$output"
done

printf '\nAll RP2350 UF2 builds completed.\n'
