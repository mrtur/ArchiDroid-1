#!/sbin/sh

#     _             _     _ ____            _     _
#    / \   _ __ ___| |__ (_)  _ \ _ __ ___ (_) __| |
#   / _ \ | '__/ __| '_ \| | | | | '__/ _ \| |/ _` |
#  / ___ \| | | (__| | | | | |_| | | | (_) | | (_| |
# /_/   \_\_|  \___|_| |_|_|____/|_|  \___/|_|\__,_|
#
# Copyright 2014 Łukasz "JustArchi" Domeradzki
# Contact: JustArchi@JustArchi.net
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Used by ArchiDroid for providing universal device-based paths
# Usage: admount.sh [Path] <Device> e.g. admount.sh /storage/sdcard1 /dev/block/mmcblk0p1
# While using <Device> is in fact optional, admount.sh will fail if fstab doesn't provide this one
# Therefore, providing <Device> argument is highly suggested

ADMOUNTED() {
	return "$(mount | grep -qi "$1"; echo $?)"
}

LOG="/dev/null" # You can enable logging if required by specifying path such as /tmp/admount.log

exec 1>>"$LOG" # Append is used for logging all mount entries in the same file
exec 2>&1

# shellcheck disable=2039
if [[ -z "$1" ]]; then
	echo "ERROR: Wrong arguments!"
	echo "ERROR: Expected: [Path] <Device>"
	echo "ERROR: Got: $*"
	exit 1
fi

echo "INFO: Mounting $2 on $1..."

if ADMOUNTED "$1"; then
	echo "SUCCESS: $1 is mounted already!"
	mount | grep -i "$1"
	exit 0
fi

# Make sure that mountpoint in fact exists
# shellcheck disable=2039
if [[ ! -d "$1" ]]; then
	mkdir -p "$1"
fi

# Stage 1 - fstab
echo "INFO: Trying fstab-based mount of $1"
mount "$1" # If fstab has proper entry for our filesystem, providing path only is enough. However, this may fail if filesystem differs or fstab has no entry
if ADMOUNTED "$1"; then
	echo "SUCCESS: $1 has been mounted properly!"
	mount | grep -i "$1"
	exit 0
else
	echo "INFO: Failed fstab-based mounting of $1. This indicates that there's no valid entry for that in the fstab!"
fi

# shellcheck disable=2039
if [[ -z "$2" ]]; then
	echo "ERROR: Wrong arguments!"
	echo "ERROR: Expected: [Path] [Device]"
	echo "ERROR: Got: $*"
	exit 1
fi

# Stage 2 - kernel
echo "INFO: Trying kernel-based mount of $1"
mount -t auto "$2" "$1" # This will handle all known by kernel filesystems, from /proc/filesystems. If we fail here, it's over
if ADMOUNTED "$1"; then
	echo "SUCCESS: $1 has been mounted properly!"
	mount | grep -i "$1"
	exit 0
else
	echo "INFO: Failed kernel-based mount of $1. This indicates that $2 device is invalid or has unknown filesystem!"
fi

echo "ERROR: All stages failed, we're not able to mount that!"
exit 1
