#!/system/bin/sh

# This script dynamically configures GUI padding and status bar layout for unified devices.
LOGF=/tmp/recovery.log

apply_left_offset()
{
    left="$1"
    # Dynamic patching of TWRP theme XML files in /twres
    for xml in $(find /twres -name "*.xml" 2>/dev/null); do
        [ -f "$xml" ] || continue
        # 1. Multi-line match: placement on row1_header_y immediately followed by cpu_temp
        sed -i -E \
            -e "/placement.*y=\"%row1_header_y%\"/{N;/cpu_temp/s/placement x=\"[^\"]*\"/placement x=\"$left\"/;}" \
            -e "s/placement x=\"(%indent%|%status_indent_left%|%col1_x%|%TW_CUSTOM_CPU_POS%|158|261)\" y=\"%row1_header_y%\"/placement x=\"$left\" y=\"%row1_header_y%\"/g" \
            -e "s/name=\"tw_cpu_pos_x\" value=\"[^\"]*\"/name=\"tw_cpu_pos_x\" value=\"$left\"/g" \
            "$xml" 2>/dev/null
    done
}

load_sm7125()
{
    setprop "tw.screen.height" "2400"
}

load_RMX2061()
{
    local left=261
    apply_left_offset "$left"
    echo "I:GUI-props: realme 6 Pro detected - calibrated status bar left offset to $left" >> $LOGF
}

load_RMX2170()
{
    local left=158
    apply_left_offset "$left"
    echo "I:GUI-props: realme 7 Pro detected - calibrated status bar left offset to $left" >> $LOGF
}

load_RMX3081()
{
    local left=158
    apply_left_offset "$left"
    echo "I:GUI-props: realme 8 Pro detected - calibrated status bar left offset to $left" >> $LOGF
}

local LOGF=/tmp/recovery.log
project=$(cat /proc/oppoVersion/prjName)

case $project in
    "20711")
        load_RMX3081
        ;;
    "206B1")
        load_RMX2170
        ;;
    "19721")
        load_RMX2061
        ;;
    *)
        echo "E:GUI-props: unsupported project:" $project >> $LOGF
        ;;
esac

load_sm7125

exit 0
