#!/system/bin/sh

# This script is needed to automatically set props for sm7125 devices (RMX2170 / RMX2061 / RMX3081)

load_RMX2061()
{
    resetprop "ro.product.model" "realme 6 Pro";
    resetprop "ro.product.name" "RMX2061";
    resetprop "ro.build.product" "RMX2061";
    resetprop "ro.product.device" "RMX2061";
    resetprop "ro.product.product.device" "RMX2061";
    resetprop "ro.vendor.product.device" "RMX2061";
    echo "I:unified-script: realme 6 Pro detected - using RMX2061 props" >> $LOGF;
}

load_RMX2170()
{
    resetprop "ro.product.model" "realme 7 Pro";
    resetprop "ro.product.name" "RMX2170";
    resetprop "ro.build.product" "RMX2170";
    resetprop "ro.product.device" "RMX2170";
    resetprop "ro.product.product.device" "RMX2170";
    resetprop "ro.vendor.product.device" "RMX2170";
    echo "I:unified-script: realme 7 Pro detected - using RMX2170 props" >> $LOGF;
}

load_RMX3081()
{
    resetprop "ro.product.model" "realme 8 Pro";
    resetprop "ro.product.name" "RMX3081";
    resetprop "ro.build.product" "RMX3081";
    resetprop "ro.product.device" "RMX3081";
    resetprop "ro.product.product.device" "RMX3081";
    resetprop "ro.vendor.product.device" "RMX3081";
    echo "I:unified-script: realme 8 Pro detected - using RMX3081 props" >> $LOGF;
}

detect_rom_android_version()
{
    local ROM_BUILD_PROP=""
    local DETECTED_SDK=""
    local DETECTED_RELEASE=""

    # Try to find the ROM's build.prop from various mount points
    for PROP_PATH in /system/build.prop /system_root/build.prop /system/system/build.prop /vendor/build.prop; do
        if [ -f "$PROP_PATH" ]; then
            ROM_BUILD_PROP="$PROP_PATH"
            echo "I:version-detect: found build.prop at $PROP_PATH" >> $LOGF
            break
        fi
    done

    if [ -z "$ROM_BUILD_PROP" ]; then
        echo "E:version-detect: no build.prop found, trying /data" >> $LOGF
        for PROP_PATH in /data/system/build.prop /data/property/persistent.prop; do
            if [ -f "$PROP_PATH" ]; then
                ROM_BUILD_PROP="$PROP_PATH"
                echo "I:version-detect: found build.prop at $PROP_PATH" >> $LOGF
                break
            fi
        done
    fi

    if [ -n "$ROM_BUILD_PROP" ]; then
        DETECTED_SDK=$(grep "^ro.build.version.sdk=" "$ROM_BUILD_PROP" 2>/dev/null | cut -d'=' -f2 | tr -d ' ')
        DETECTED_RELEASE=$(grep "^ro.build.version.release=" "$ROM_BUILD_PROP" 2>/dev/null | cut -d'=' -f2 | tr -d ' ')
        DETECTED_SECURITY_PATCH=$(grep "^ro.build.version.security_patch=" "$ROM_BUILD_PROP" 2>/dev/null | cut -d'=' -f2 | tr -d ' ')
        DETECTED_DISPLAY_ID=$(grep "^ro.build.display.id=" "$ROM_BUILD_PROP" 2>/dev/null | cut -d'=' -f2 | tr -d ' ')

        if [ -n "$DETECTED_SDK" ]; then
            resetprop "ro.build.version.sdk" "$DETECTED_SDK"
            echo "I:version-detect: set ro.build.version.sdk=$DETECTED_SDK" >> $LOGF
        fi

        if [ -n "$DETECTED_RELEASE" ]; then
            resetprop "ro.build.version.release" "$DETECTED_RELEASE"
            echo "I:version-detect: set ro.build.version.release=$DETECTED_RELEASE" >> $LOGF
        fi

        if [ -n "$DETECTED_SECURITY_PATCH" ]; then
            resetprop "ro.build.version.security_patch" "$DETECTED_SECURITY_PATCH"
            echo "I:version-detect: set ro.build.version.security_patch=$DETECTED_SECURITY_PATCH" >> $LOGF
        fi

        if [ -n "$DETECTED_DISPLAY_ID" ]; then
            resetprop "ro.build.display.id" "$DETECTED_DISPLAY_ID"
            echo "I:version-detect: set ro.build.display.id=$DETECTED_DISPLAY_ID" >> $LOGF
        fi

        # Set Android version codename based on SDK
        case "$DETECTED_SDK" in
            36)
                resetprop "ro.build.version.codename" "Baklava"
                resetprop "ro.build.version.preview_sdk" "0"
                echo "I:version-detect: Android 16 (SDK 36) detected" >> $LOGF
                ;;
            35)
                resetprop "ro.build.version.codename" "VanillaIceCream"
                resetprop "ro.build.version.preview_sdk" "0"
                echo "I:version-detect: Android 15 (SDK 35) detected" >> $LOGF
                ;;
            34)
                resetprop "ro.build.version.codename" "UpsideDownCake"
                resetprop "ro.build.version.preview_sdk" "0"
                echo "I:version-detect: Android 14 (SDK 34) detected" >> $LOGF
                ;;
            33)
                resetprop "ro.build.version.codename" "Tiramisu"
                resetprop "ro.build.version.preview_sdk" "0"
                echo "I:version-detect: Android 13 (SDK 33) detected" >> $LOGF
                ;;
            32)
                resetprop "ro.build.version.codename" "S_V2"
                resetprop "ro.build.version.preview_sdk" "0"
                echo "I:version-detect: Android 12L (SDK 32) detected" >> $LOGF
                ;;
            31)
                resetprop "ro.build.version.codename" "S"
                resetprop "ro.build.version.preview_sdk" "0"
                echo "I:version-detect: Android 12 (SDK 31) detected" >> $LOGF
                ;;
            *)
                echo "I:version-detect: unknown SDK $DETECTED_SDK" >> $LOGF
                ;;
        esac
    else
        echo "E:version-detect: could not find any build.prop" >> $LOGF
    fi
}

LOGF=/tmp/recovery.log;
project=$(cat /proc/oppoVersion/prjName 2>/dev/null);
[ -z "$project" ] && project=$(cat /proc/oplusVersion/prjName 2>/dev/null);

resetprop "ro.separate.soft" "$project";

case "$project" in
    "20711")
        load_RMX3081
        ;;
    "206B1"|"206b1")
        load_RMX2170
        ;;
    "19721"|*)
        load_RMX2061
        ;;
esac

# Detect and set ROM's Android version
detect_rom_android_version

exit 0
