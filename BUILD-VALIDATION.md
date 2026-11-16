# v2.0 RP2350 Build Matrix

Build date: 2026-11-16

All four configured RP2350 targets compiled successfully. `picotool info`
reports version 2.0, target RP2350, and ARM Secure image type for each UF2.
The startup string was also checked in each ELF:

`patched with love & hate by @nattramn669`

## Artifacts

| Board | UF2 | SHA-256 | Hardware status |
| --- | --- | --- | --- |
| Waveshare RP2350 USB-A | `artifacts/v2.0-rp2350/usbliter8-v2.0-waveshare_rp2350_usb_a.uf2` | `744909e54009b7c3ed3a2c1bc33ff2d32a53f3d2a0e935ef336566bc12c35cb8` | This exact build not tested |
| Waveshare RP2350 Zero | `artifacts/v2.0-rp2350/usbliter8-v2.0-waveshare_rp2350_zero.uf2` | `9375e05689a26c50b3d852a19926c816e93a9c2e77e46abe1053fb60db07002d` | Not tested |
| Pimoroni TINY2350 | `artifacts/v2.0-rp2350/usbliter8-v2.0-pimoroni_tiny2350.uf2` | `3b0fb063536319b66bc1d0351c1162453ca4d307ae49b505e9373ef8ba37dbff` | Not tested |
| Raspberry Pi Pico 2 | `artifacts/v2.0-rp2350/usbliter8-v2.0-pico2.uf2` | `242e91cea0d8a53dd793f3152278140a82265d9cb8cec4061f1cc211fb019ef7` | Not tested |

The user previously reported a successful iPad 9 Wi-Fi exploit with an earlier
Waveshare USB-A build. That report does not validate these exact binaries. The
Cellular BDID mapping (`0x1a`) and the other three boards still need hardware
tests. Because exploit timing can vary with binary layout and board wiring,
keep the earlier known-good UF2 as a separate control during testing.

## Build Environment

- Pico SDK: 2.2.0
- ARM GNU Toolchain: 13.2.1
- Target platform: `rp2350-arm-s`
- Board configs: Waveshare USB-A, Waveshare Zero, Pimoroni TINY2350, Pico 2

Build all targets with `./build_release.sh`. It keeps separate build
directories under `build-rp2350/` and writes outputs under
`artifacts/v2.0-rp2350/`; it does not remove existing build/output trees.
