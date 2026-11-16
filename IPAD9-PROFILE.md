# iPad 9 Profile (v2.0)

The startup banner identifies this build as version 2.0 and prints
`patched with love & hate by @nattramn669`.

## Dispatch

Device identity is read from the existing Apple DFU serial descriptor. The
standard T8030 shellcode is selected by default. The iPad 9 Wi-Fi profile
(`CPID 0x8030 + BDID 0x18`) and iPad 9 Cellular profile
(`CPID 0x8030 + BDID 0x1a`) select `resources/shellcode_t8030_ipad9.h`.
T8020/T8006 dispatch and all USB exploit sequencing remain on the upstream
path. The cellular mapping is included for hardware validation; success on
Wi-Fi does not establish success on Cellular.

## iPad 9 SecureROM additions

The iPad 9 `rom_patchup()` adds four writes to the existing T8030 patch set:

| ROM offset | Value | Instruction | Purpose inferred from disassembly |
| --- | --- | --- | --- |
| `0x763c` | `0xd503201f` | `nop` | Bypass an early range rejection |
| `0x7644` | `0x52800008` | `mov w8, #0` | Force lookup index zero |
| `0x766c` | `0xd503201f` | `nop` | Keep the following result path |
| `0x795c` | `0xd503201f` | `nop` | Skip the helper call using operation `0x1402` |

These semantic descriptions are interpretations of the recovered instructions,
not confirmed names for the hardware operation. The matching binary payload
was extracted from the following UF2 and checked against the previously
recorded payload hash:

- UF2 SHA-256: `2a30fa01e15db5d5c6738341fe2ead04e3c0556ee8f4368f31c42eb334b35651`
- iPad 9 T8030 shellcode: 1,168 bytes (`0x490`)
- Shellcode SHA-256: `1cdc1f1f62c838c46e76cc744711b201b4d385e216e6b920e97c5f1b3b075b3e`

## Build

The embedded shellcode headers permit the normal Pico SDK build without
rebuilding ARM64 shellcode. To regenerate the iPad 9 shellcode, use
`t8030_shellcode/make.sh` with Apple's ARM64 clang and the upstream `vmacho`
utility available in `PATH`. The script deliberately leaves the original 1.0
T8030 header untouched so a different local compiler cannot silently change
the default behavior for other boards.

```sh
cmake -S . -B build -DPICO_BOARD=waveshare_rp2350_usb_a \
  -DPICO_SDK_PATH=/path/to/pico-sdk
cmake --build build
```

This is a static/source adaptation. Build success does not prove runtime
success on the iPad 9; validate only with the known-good device and a recovery
path available.
