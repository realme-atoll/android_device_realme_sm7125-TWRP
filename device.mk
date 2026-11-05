#
# Copyright (C) 2021-2026 TeamWin Recovery Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Location-independent device path
DEVICE_PATH ?= $(patsubst %/,%,$(dir $(lastword $(MAKEFILE_LIST))))
ifeq ($(DEVICE_PATH),)
  DEVICE_PATH := device/realme/sm7125
endif

# Dynamic Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Shipping API Level
PRODUCT_SHIPPING_API_LEVEL := 29

# Realme UI Stock OTA Keys
PRODUCT_EXTRA_RECOVERY_KEYS += \
    $(DEVICE_PATH)/security/realme.special_OTA \
    $(DEVICE_PATH)/security/realme.local_OTA

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# Recovery HALs and libraries
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.1

TARGET_RECOVERY_DEVICE_MODULES += \
    android.hidl.base@1.0 \
    android.hardware.gatekeeper@1.0 \
    android.hardware.keymaster@4.0 \
    android.hardware.keymaster@4.1 \
    libbase \
    libcap \
    libcrypto \
    libcutils \
    libdrm \
    libhardware \
    libhidlbase \
    libhidltransport \
    libhwbinder \
    libion \
    liblog \
    libpcrecpp \
    libutils \
    libxml2

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hidl.base@1.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.gatekeeper@1.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.keymaster@4.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.keymaster@4.1.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libbase.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libcap.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libcrypto.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libcutils.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libdrm.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libhardware.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libhidlbase.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libhidltransport.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libhwbinder.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/liblog.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libpcrecpp.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libutils.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libxml2.so

# Qualcomm Decryption packages
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe \
    recovery_android.hardware.keymaster@4.0-service-qti \
    recovery_android.hardware.gatekeeper@1.0-service-qti \
    recovery_qseecomd \
    recovery_libQSEEComAPI \
    recovery_libdiag \
    recovery_libdrmfs \
    recovery_libqcbor \
    recovery_libkeymasterdeviceutils \
    recovery_libkeymasterutils \
    recovery_libqtikeymaster4 \
    recovery_android.hardware.gatekeeper@1.0-impl-qti

# Compression tools for modern payload / images
PRODUCT_PACKAGES += \
    zstd

# Enable file-based encryption
PRODUCT_PROPERTY_OVERRIDES += \
    ro.crypto.file_based=true \
    ro.crypto.metadata_encryption=true

TARGET_USE_CUSTOM_LUN_FILE_PATH := "/config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file"

# Add device-specific partition metadata explicitly. Common recovery init
# files are provided by the shared device configuration.
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/recovery/root/init.recovery.usb.rc:recovery/root/init.recovery.usb.rc \
    $(DEVICE_PATH)/recovery/root/system/etc/twrp.flags:recovery/root/system/etc/twrp.flags \
    $(DEVICE_PATH)/recovery/root/ueventd.qcom.rc:recovery/root/ueventd.qcom.rc \
    $(DEVICE_PATH)/recovery/root/vendor/etc/vintf/manifest.xml:recovery/root/vendor/etc/vintf/manifest.xml \
    $(DEVICE_PATH)/recovery/root/system/bin/runatboot.sh:recovery/root/system/bin/runatboot.sh
