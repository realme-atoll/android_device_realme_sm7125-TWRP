#!/system/bin/sh

# Identify the handset on the unified sm7125 target and set its recovery UI position.
LOGF=/tmp/recovery.log
project=$(cat /proc/oppoVersion/prjName 2>/dev/null | tr -d '\r\n ')
[ -z "$project" ] && project=$(cat /proc/oplusVersion/prjName 2>/dev/null | tr -d '\r\n ')

# Device-specific recovery products provide ro.product.device as a fallback;
# the shared sm7125 product relies on the hardware project ID above.
case "$project" in
    20711)
        device=RMX3081
        model="realme 8 Pro"
        ui_position=158
        ;;
    206B1|206b1)
        device=RMX2170
        model="realme 7 Pro"
        ui_position=158
        ;;
    19721)
        device=RMX2061
        model="realme 6 Pro"
        ui_position=261
        ;;
    *)
        case "$(getprop ro.product.device)" in
            RMX3081)
                device=RMX3081
                model="realme 8 Pro"
                ui_position=158
                ;;
            RMX2170)
                device=RMX2170
                model="realme 7 Pro"
                ui_position=158
                ;;
            RMX2061|RMX2063)
                device=RMX2061
                model="realme 6 Pro"
                ui_position=261
                ;;
            *)
                echo "W:device-detect: unknown project '$project' and product '$(getprop ro.product.device)'; keeping build defaults" >> "$LOGF"
                exit 0
                ;;
        esac
        ;;
esac

if [ -n "$project" ]; then
    resetprop ro.separate.soft "$project"
fi
resetprop ro.product.model "$model"
resetprop ro.product.name "$device"
resetprop ro.build.product "$device"
resetprop ro.product.device "$device"
resetprop ro.product.product.device "$device"
resetprop ro.vendor.product.device "$device"
resetprop ro.product.vendor.device "$device"
resetprop ro.product.system.device "$device"
resetprop ro.product.system_ext.device "$device"
resetprop ro.product.odm.device "$device"
echo "I:device-detect: $model ($device), UI position $ui_position" >> "$LOGF"

# TWRP positions the CPU temperature label with tw_cpu_pos_x.
ui_xml=/twres/ui.xml
if [ -w "$ui_xml" ]; then
    sed -i 's/name="tw_cpu_pos_x" value="[^"]*"/name="tw_cpu_pos_x" value="'"$ui_position"'"/' "$ui_xml"
fi

exit 0
