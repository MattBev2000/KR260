#!/usr/bin/env bash
# Launch Vivado with the libudev preload workaround.

work_dir="/opt/2025.1/Vivado"
mkdir -p -- "$work_dir" || exit 1
cd -- "$work_dir" || exit 1

source /opt/2025.1/Vivado/settings64.sh || exit 1

udev_lib="/lib/x86_64-linux-gnu/libudev.so.1"

if [[ ! -r "$udev_lib" ]]; then
    echo "ERROR: library not found: $udev_lib"
    exit 1
fi

LD_PRELOAD="$udev_lib${LD_PRELOAD:+:$LD_PRELOAD}" vivado "$@"
