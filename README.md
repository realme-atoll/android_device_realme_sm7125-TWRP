TeamWin Recovery Project (TWRP) for realme 6 Pro, 7 Pro & 8 Pro (sm7125)
===================================================================================

# Device Support
This branch includes TWRP with full support for **realme 6 Pro (RMX2061)**, **realme 7 Pro (RMX2170)**, and **realme 8 Pro (RMX3081)**:
- **Device support**: Automatically detects device model and applies dynamic cutout and status bar offsets
- **Android Support**: Multi-version Android support (Android 11 through Android 16) with latest security patches
- **Dynamic Partitions**: Standard Retrofit Dynamic Partitions (system, system_ext, product, vendor, odm)
- **FBE v2** with metadata encryption
- **Input**: Native support for modern AIDL touch and HIDX HALs
- **Fastbootd**: Userspace fastboot (`fastbootd`) enabled for dynamic partition management
- **File Systems**: Full support for EroFS, EXT4, and F2FS partitions

## Features
- Dynamic hole-punch cutout calibration for single-hole (7 Pro / 8 Pro) and dual-hole (6 Pro) displays
- Decryption support for Android 16 with PIN/pattern/password
- Retrofit dynamic partitions management in fastbootd and recovery
- Advanced partition backup/restore (Boot, Recovery, Super, DTBO, VBMeta, EFS, Persist, Firmware)
- USB-OTG and MicroSD storage support
- MTP support for direct file transfer from PC
- LZ4 and ZSTD compression support

# How to build
Check TWRP official guide https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp

```bash
# Set up build environment
. build/envsetup.sh
lunch twrp_sm7125-eng
mka recoveryimage -j$(nproc --all)
```

## Device specifications

| Feature | realme 6 Pro (RMX2061) | realme 7 Pro (RMX2170) | realme 8 Pro (RMX3081) |
| :--- | :--- | :--- | :--- |
| **SoC** | Qualcomm SM7125 Snapdragon 720G | Qualcomm SM7125 Snapdragon 720G | Qualcomm SM7125 Snapdragon 720G |
| **CPU** | Octa-core (2x2.3 GHz Kryo 465 Gold & 6x1.8 GHz Kryo 465 Silver) | Octa-core (2x2.3 GHz Kryo 465 Gold & 6x1.8 GHz Kryo 465 Silver) | Octa-core (2x2.3 GHz Kryo 465 Gold & 6x1.8 GHz Kryo 465 Silver) |
| **GPU** | Adreno 618 | Adreno 618 | Adreno 618 |
| **Memory** | 6/8 GB RAM | 6/8 GB RAM | 6/8 GB RAM |
| **Storage** | 64/128 GB UFS 2.1 | 128 GB UFS 2.1 | 128 GB UFS 2.1 |
| **Battery** | 4300 mAh (30W VOOC 4.0) | 4500 mAh (65W SuperDart) | 4500 mAh (50W SuperDart) |
| **Display** | 6.6" 90Hz IPS LCD (1080 x 2400) | 6.4" Super AMOLED (1080 x 2400) | 6.4" Super AMOLED (1080 x 2400) |
| **Cutout** | Dual Punch-hole Pill (Left) | Single Punch-hole (Left) | Single Punch-hole (Left) |

---
## Maintainer

* **Nikhil Suryavanshi** ([@nikhilpal2705](https://github.com/nikhilpal2705))
* **Organization**: [realme-atoll](https://github.com/realme-atoll)
