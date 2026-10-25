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

# Dynamic Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Shipping API Level
PRODUCT_SHIPPING_API_LEVEL := 29

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# Recovery HALs and libraries
TARGET_RECOVERY_DEVICE_MODULES += \
    android.hidl.base@1.0 \
    libcap \
    libdrm \
    libion \
    libpcrecpp \
    libxml2

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hidl.base@1.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libcap.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libdrm.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libpcrecpp.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libxml2.so

# Qualcomm Decryption packages
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Compression tools for modern payload / images
PRODUCT_PACKAGES += \
    lz4 \
    zstd

TARGET_USE_CUSTOM_LUN_FILE_PATH := "/config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file"
