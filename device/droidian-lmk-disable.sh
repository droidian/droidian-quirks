#!/bin/sh
#
# Disable lowmemorykiller for now
#

[ -e /sys/module/lowmemorykiller/parameters/enable_lmk ] echo 0 > /sys/module/lowmemorykiller/parameters/enable_lmk
[ -e /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk ] && echo 0 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk

exit 0
