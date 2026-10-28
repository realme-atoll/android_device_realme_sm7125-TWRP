#
# Copyright (C) 2021 The Android Open Source Project
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

LOCAL_PATH := $(call my-dir)

ifneq (,$(filter $(TARGET_DEVICE),sm7125 RMX2061 RMX2063 RMX2170 RMX3081 atoll))
include $(call all-subdir-makefiles,$(LOCAL_PATH))

# Android rejects vendor ELF files in PRODUCT_COPY_FILES. Declare them as
# recovery prebuilts so the linker checker can verify their dependencies.
define recovery-prebuilt
include $$(CLEAR_VARS)
LOCAL_MODULE := recovery_$1
LOCAL_MODULE_CLASS := $2
LOCAL_MODULE_PATH := $$(TARGET_RECOVERY_ROOT_OUT)/$3
LOCAL_MODULE_STEM := $1
LOCAL_MODULE_SUFFIX := $5
LOCAL_SRC_FILES := recovery/root/$3/$1$5
LOCAL_SHARED_LIBRARIES := $4
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_TARGET_ARCH := arm64
LOCAL_MULTILIB := 64
include $$(BUILD_PREBUILT)
endef

$(eval $(call recovery-prebuilt,android.hardware.keymaster@4.0-service-qti,EXECUTABLES,system/bin,android.hardware.keymaster@4.0 android.hardware.keymaster@4.1 libbase libcutils libhardware libhidlbase libhidltransport libhwbinder liblog recovery_libqtikeymaster4 libutils libcrypto,))
$(eval $(call recovery-prebuilt,android.hardware.gatekeeper@1.0-service-qti,EXECUTABLES,system/bin,android.hardware.gatekeeper@1.0 libhardware libhidlbase libhidltransport libhwbinder liblog libutils,))
$(eval $(call recovery-prebuilt,qseecomd,EXECUTABLES,system/bin,recovery_libQSEEComAPI libcutils recovery_libdrmfs liblog libutils,))

$(eval $(call recovery-prebuilt,libQSEEComAPI,SHARED_LIBRARIES,system/lib64,libcutils libion liblog libutils,.so))
$(eval $(call recovery-prebuilt,libdiag,SHARED_LIBRARIES,system/lib64,libcutils liblog,.so))
$(eval $(call recovery-prebuilt,libqcbor,SHARED_LIBRARIES,system/lib64,liblog libutils,.so))
$(eval $(call recovery-prebuilt,libdrmfs,SHARED_LIBRARIES,system/lib64,recovery_libQSEEComAPI libcutils recovery_libdiag liblog libutils libxml2,.so))
$(eval $(call recovery-prebuilt,libkeymasterdeviceutils,SHARED_LIBRARIES,system/lib64,recovery_libQSEEComAPI libcrypto libcutils libion liblog,.so))
$(eval $(call recovery-prebuilt,libkeymasterutils,SHARED_LIBRARIES,system/lib64,recovery_libQSEEComAPI libcrypto libcutils liblog,.so))
$(eval $(call recovery-prebuilt,libqtikeymaster4,SHARED_LIBRARIES,system/lib64,android.hardware.keymaster@4.0 android.hardware.keymaster@4.1 libbase libcrypto libcutils libhidlbase libhidltransport libhwbinder recovery_libkeymasterdeviceutils recovery_libkeymasterutils recovery_libqcbor liblog libutils,.so))
$(eval $(call recovery-prebuilt,android.hardware.gatekeeper@1.0-impl-qti,SHARED_LIBRARIES,vendor/lib64/hw,android.hardware.gatekeeper@1.0 libhidlbase libhidltransport libhwbinder recovery_libkeymasterdeviceutils recovery_libqcbor liblog libutils libcutils,.so))

include $(CLEAR_VARS)

# Normalize recovery build timestamp for installer compatibility
BOARD_RECOVERY_IMAGE_PREPARE := \
    sed -i 's/ro.build.date.utc=.*/ro.build.date.utc=0/' $(TARGET_RECOVERY_ROOT_OUT)/prop.default

endif
