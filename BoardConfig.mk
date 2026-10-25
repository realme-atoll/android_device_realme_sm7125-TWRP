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

DEVICE_PATH ?= $(patsubst %/,%,$(dir $(lastword $(MAKEFILE_LIST))))
ifeq ($(DEVICE_PATH),)
  DEVICE_PATH := device/realme/sm7125
endif

# Shared device settings are in BoardConfigCommon.mk; tree-specific settings follow.
include $(DEVICE_PATH)/BoardConfigCommon.mk

# Recovery-specific ramdisk folders
BOARD_ROOT_EXTRA_FOLDERS += cache

# Tools and binaries
TW_INCLUDE_LIBRESETPROP := true

# Use the legacy battery service required by this device.
TW_USE_LEGACY_BATTERY_SERVICES := true

# Avoid legacy property handling in this recovery build.
TW_NO_LEGACY_PROPS := true
