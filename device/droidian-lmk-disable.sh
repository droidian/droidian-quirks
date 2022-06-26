#!/bin/sh
#
# Disable lowmemorykiller for now
#

echo 0 > /sys/module/lowmemorykiller/parameters/enable_lmk
echo 0 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk

exit 0
