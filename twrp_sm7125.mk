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

# Inherit from those products by extension
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Inherit from common TWRP configuration
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from sm7125 device
$(call inherit-product, device/realme/sm7125/device.mk)

# Device identifier
PRODUCT_DEVICE := sm7125
PRODUCT_NAME := twrp_sm7125
PRODUCT_BRAND := realme
PRODUCT_MODEL := realme 7 Pro / 6 Pro / 8 Pro
PRODUCT_MANUFACTURER := realme
PRODUCT_RELEASE_NAME := sm7125
