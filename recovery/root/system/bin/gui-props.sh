#!/system/bin/sh

# This script automatically sets GUI props for sm7125 devices (RMX2170 / RMX2061 / RMX3081)

load_RMX2061()
{
    setprop "tw.status.left.offset" "261";
    setprop "tw.status.height.offset" "132";
    setprop "tw.status.placement.offset" "40";
    setprop "tw.status.right.offset" "34";
    setprop "tw.screen.height" "2400";
    echo "I:GUI-props: using props for realme 6 Pro (RMX2061)" >> $LOGF;
}

load_RMX2170()
{
    setprop "tw.status.left.offset" "158";
    setprop "tw.status.height.offset" "140";
    setprop "tw.status.placement.offset" "40";
    setprop "tw.status.right.offset" "34";
    setprop "tw.screen.height" "2400";
    echo "I:GUI-props: using props for realme 7 Pro (RMX2170)" >> $LOGF;
}

load_RMX3081()
{
    setprop "tw.status.left.offset" "158";
    setprop "tw.status.height.offset" "140";
    setprop "tw.status.placement.offset" "40";
    setprop "tw.status.right.offset" "34";
    setprop "tw.screen.height" "2400";
    echo "I:GUI-props: using props for realme 8 Pro (RMX3081)" >> $LOGF;
}

LOGF=/tmp/recovery.log;
project=$(cat /proc/oppoVersion/prjName 2>/dev/null);
[ -z "$project" ] && project=$(cat /proc/oplusVersion/prjName 2>/dev/null);

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

exit 0
