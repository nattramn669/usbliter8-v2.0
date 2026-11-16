# usbliter8 source v2.0: iPad 9 profile

This is a source-based v2.0 fork of the clean upstream 1.0 reference. It adds
the SecureROM shellcode observed in the reported functional iPad 9 UF2 and
selects it for T8030 BDID `0x18` (Wi-Fi) and `0x1a` (Cellular). Other T8030
boards keep the original 1.0 shellcode; the T8020/T8006 path is unchanged.

The UF2 that supplied the iPad 9 shellcode was statically inspected. Its
SHA-256 is recorded in `IPAD9-PROFILE.md`. Hardware success is based on the
user's test report, not a device run performed from this build environment.
