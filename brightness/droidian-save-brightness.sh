#!/bin/bash
#
# Alternative to systemd-backlight save to workaround kernels with
# unreliable `actual_brightness`.
# systemd doesn't allow forcing `brightness`, so let's use this
# script to do that instead.
#
# Always read from `brightness` which is the same behaviour of
# gnome-settings-daemon.

ACTION="${1}"
DEVICE_SLUG="${2}"
SYSTEMD_STORAGE="/var/lib/systemd/backlight"

subsystem=$(echo ${DEVICE_SLUG} | cut -d':' -f1)
device=$(echo ${DEVICE_SLUG} | cut -d':' -f2)
device_path="/sys/class/${subsystem}/${device}"

# Try to determine the systemd-backlight save file
device_id_path=$(udevadm info --query=property --property=ID_PATH --value ${device_path})
if [ -n "${device_id_path}" ]; then
	target_name="${device_id_path}:${subsystem}:${device}"
else
	target_name="${subsystem}:${device}"
fi

target_path="${SYSTEMD_STORAGE}/${target_name}"
mkdir -p ${SYSTEMD_STORAGE}

if [ "${ACTION}" == "save" ] && [ -e "${device_path}/brightness" ]; then
	cat ${device_path}/brightness > "${target_path}"
elif [ "${ACTION}" == "bootstrap" ] && [ -e "${device_path}/max_brightness" ]; then
	echo "$(($(cat ${device_path}/max_brightness)/2))" > "${target_path}"
elif [ "${ACTION}" == "bootstrap" ]; then
	echo 50 > "${target_path}"
else
	exec /lib/systemd/systemd-backlight ${@}
fi
