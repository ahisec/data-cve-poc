# DCS-932L Firmware Reverse Engineering Toolkit

Welcome to the DCS-932L Firmware. This repository contains tools and modifications to aid in the reverse engineering of the DCS-932L firmware.

## Modifications

Several modifications have been made to enhance the functionality and usability of the firmware emulation environment:

1. **Startup Script:** Added a startup script (`startup.sh`) to simplify emulation.
2. **Libnvram.so Adjustment:** Removed lines 338 to 342 of `libnvram.so` to ensure proper functioning of the NVRAM emulator. The modified file has been placed in the correct folder.
3. **Firmadyne Integration:** Added the Firmadyne folder to facilitate firmware emulation.
4. **Alphapd Patch:** Patched Alphapd using Ghidra to resolve the error preventing IP retrieval from sysinfo.
5. **Qemu-mipsel-static Addition:** Included qemu-mipsel-static in the folder for enhanced functionality.

## Usage

To begin using the toolkit, follow these steps:

## 🛠️ Emulating DCS-932L Firmware

Follow these steps to emulate the D-Link DCS-932L firmware using QEMU and chroot.

### 1. Clone the Repository

```bash
git clone https://github.com/itwizardo/DCS-932L.git
cd DCS-932L
```

### 2. Clone the Repository

```bash
chattr +i etc_ro/web/
```

### 3. Install QEMU User Emulation Tools

```bash
sudo apt update
sudo apt install qemu-user-static
```

### 4. (Optional) Check Your Firmware Path

```bash
cd usr/bin
pwd
cd ../../
```

This shows your full firmware path in case you need it for debugging.

### 5. Copy QEMU to the Firmware

```bash
sudo cp /usr/bin/qemu-mipsel-static ./usr/bin/
```

### 6. Enter the Chroot Environment

```bash
sudo chroot . /usr/bin/qemu-mipsel-static /bin/sh
```

### 7. Run the Startup Script

```bash
./startup.sh
```

### 8. Set Environment Variables (Inside Chroot)

```bash
export LD_PRELOAD=/firmadyne/libnvram.so
export HOME=.
export RANDFILE=$HOME/.rnd
```

### 9. Start Alphapd

```bash
alphapd
```

### ⚠️ Notes

- This firmware is **MIPS Little Endian**, so you **must** use `qemu-mipsel-static`.
- Using `qemu-mips-static` will result in `Invalid ELF image` errors.
- Ensure that `/lib/ld



## Disclaimer

This project is for educational purposes only, developed as part of a school project for Novi Hogeschool.

## Author

Georgio T. - [itwizardo](https://github.com/itwizardo)

Feel free to contribute to this project and improve the tools for firmware reverse engineering!
