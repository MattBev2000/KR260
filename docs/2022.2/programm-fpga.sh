#!/usr/bin/env bash

set -euo pipefail

###############################################################################
# FPGA Programming Script for PetaLinux / KRIA KR260
###############################################################################
#
# Description:
#   This script programs the FPGA fabric from a running PetaLinux system by using
#   the Linux FPGA Manager interface. It is intended to be executed directly on
#   the target board, for example through a serial terminal or an SSH connection.
#
#   The script can optionally load a device-tree overlay after programming the
#   FPGA and can optionally insert a kernel module after the overlay has been
#   applied. This is useful for designs based on custom AXI peripherals, AXI DMA,
#   FIFOs, registers or custom Linux drivers.
#
# Requirements:
#   - The bitstream must be provided in binary format, usually with .bin extension.
#   - FPGA Manager must be enabled in the PetaLinux configuration.
#   - For overlay loading, configfs support must be available in the kernel.
#   - The script must normally be run as root.
#
# Typical usage:
#   sudo ./program_fpga_petalinux.sh -b design_1_wrapper.bin
#
#   sudo ./program_fpga_petalinux.sh \
#       -b design_1_wrapper.bin \
#       -o pl-design.dtbo \
#       -n pl-design
#
#   sudo ./program_fpga_petalinux.sh \
#       -b design_1_wrapper.bin \
#       -o pl-design.dtbo \
#       -n pl-design \
#       -k mydriver.ko
#
###############################################################################

###############################################################################
# Functions
###############################################################################
usage() {
    cat <<USAGE
Usage:
  sudo $0 -b <bitstream.bin> [options]

Required:
  -b <file>     FPGA bitstream in .bin format

Optional:
  -o <file>     Device-tree overlay in .dtbo format
  -n <name>     Overlay name under /sys/kernel/config/device-tree/overlays
  -k <file>     Kernel module .ko to insert after FPGA/overlay loading
  -f            Force reload: remove existing overlay with the same name first
  -h            Show this help message

Examples:
  sudo $0 -b design_1_wrapper.bin

  sudo $0 -b design_1_wrapper.bin -o pl-design.dtbo -n pl-design

  sudo $0 -b design_1_wrapper.bin -o pl-design.dtbo -n pl-design -k mydriver.ko
USAGE
}

error_exit() {
    echo "ERROR: $1" >&2
    exit 1
}

check_file_exists() {
    local file="$1"

    if [[ ! -f "$file" ]]; then
        error_exit "File not found: $file"
    fi
}

check_root() {
    if [[ "$(id -u)" -ne 0 ]]; then
        error_exit "This script must be run as root. Use sudo."
    fi
}

copy_to_firmware() {
    local src_file="$1"
    local dst_file="/lib/firmware/$(basename "$src_file")"
    local fw_name=""

    fw_name="$(basename "$src_file")"

    echo "Copying to firmware directory:" >&2
    echo "  $src_file" >&2
    echo "  -> $dst_file" >&2

    cp "$src_file" "$dst_file"
    sync

    printf '%s\n' "$fw_name"
}

check_fpga_manager() {
    if [[ ! -d "/sys/class/fpga_manager/fpga0" ]]; then
        error_exit "FPGA Manager not found at /sys/class/fpga_manager/fpga0"
    fi

    if [[ ! -w "/sys/class/fpga_manager/fpga0/firmware" ]]; then
        error_exit "Cannot write to /sys/class/fpga_manager/fpga0/firmware"
    fi
}

program_fpga() {
    local bitstream_name="$1"

    echo
    echo "Programming FPGA with:"
    echo "  $bitstream_name"

    if [[ -z "$bitstream_name" ]]; then
        error_exit "Empty bitstream firmware name."
    fi

    if [[ ! -f "/lib/firmware/$bitstream_name" ]]; then
        error_exit "Firmware file not found in /lib/firmware: $bitstream_name"
    fi

    echo "$bitstream_name" > /sys/class/fpga_manager/fpga0/firmware
    sync

    echo "FPGA programming request sent."

    if [[ -f "/sys/class/fpga_manager/fpga0/state" ]]; then
        echo "FPGA Manager state:"
        cat /sys/class/fpga_manager/fpga0/state
    fi
}

ensure_configfs() {
    if [[ ! -d "/sys/kernel/config" ]]; then
        error_exit "/sys/kernel/config does not exist. configfs support may be missing."
    fi

    if ! mountpoint -q /sys/kernel/config; then
        echo "Mounting configfs..."
        mount -t configfs configfs /sys/kernel/config
    fi

    if [[ ! -d "/sys/kernel/config/device-tree/overlays" ]]; then
        error_exit "Device-tree overlay configfs path not found. Overlay support may be missing."
    fi
}

remove_existing_overlay() {
    local overlay_name="$1"
    local overlay_dir="/sys/kernel/config/device-tree/overlays/$overlay_name"

    if [[ -d "$overlay_dir" ]]; then
        echo "Removing existing overlay:"
        echo "  $overlay_name"
        rmdir "$overlay_dir"
    fi
}

load_overlay() {
    local overlay_name="$1"
    local overlay_file_name="$2"
    local overlay_dir="/sys/kernel/config/device-tree/overlays/$overlay_name"

    echo
    echo "Loading device-tree overlay:"
    echo "  name: $overlay_name"
    echo "  file: $overlay_file_name"

    if [[ -z "$overlay_file_name" ]]; then
        error_exit "Empty overlay firmware name."
    fi

    if [[ ! -f "/lib/firmware/$overlay_file_name" ]]; then
        error_exit "Overlay file not found in /lib/firmware: $overlay_file_name"
    fi

    if [[ -d "$overlay_dir" ]]; then
        error_exit "Overlay already exists: $overlay_name. Use -f to force reload."
    fi

    mkdir "$overlay_dir"
    echo "$overlay_file_name" > "$overlay_dir/path"
    sync

    echo "Device-tree overlay loaded."
}

load_kernel_module() {
    local module_path="$1"

    echo
    echo "Loading kernel module:"
    echo "  $module_path"

    insmod "$module_path"

    echo "Kernel module loaded."
}

###############################################################################
# Parse arguments
###############################################################################
BITSTREAM_PATH=""
OVERLAY_PATH=""
OVERLAY_NAME=""
MODULE_PATH=""
FORCE_RELOAD=false

while getopts ":b:o:n:k:fh" opt; do
    case "$opt" in
        b)
            BITSTREAM_PATH="$OPTARG"
            ;;
        o)
            OVERLAY_PATH="$OPTARG"
            ;;
        n)
            OVERLAY_NAME="$OPTARG"
            ;;
        k)
            MODULE_PATH="$OPTARG"
            ;;
        f)
            FORCE_RELOAD=true
            ;;
        h)
            usage
            exit 0
            ;;
        :)
            usage
            error_exit "Option -$OPTARG requires an argument."
            ;;
        \?)
            usage
            error_exit "Invalid option: -$OPTARG"
            ;;
    esac
done

###############################################################################
# Validate inputs
###############################################################################
if [[ -z "$BITSTREAM_PATH" ]]; then
    usage
    error_exit "Missing required bitstream file."
fi

check_root
check_file_exists "$BITSTREAM_PATH"
check_fpga_manager

if [[ -n "$OVERLAY_PATH" ]]; then
    check_file_exists "$OVERLAY_PATH"

    if [[ -z "$OVERLAY_NAME" ]]; then
        OVERLAY_NAME="$(basename "$OVERLAY_PATH" .dtbo)"
    fi
fi

if [[ -n "$MODULE_PATH" ]]; then
    check_file_exists "$MODULE_PATH"
fi

###############################################################################
# Main flow
###############################################################################
echo
echo "========================================================"
echo "FPGA PROGRAMMING FROM PETALINUX"
echo "========================================================"
echo

BITSTREAM_FW_NAME="$(copy_to_firmware "$BITSTREAM_PATH")"

if [[ -n "$OVERLAY_PATH" ]]; then
    OVERLAY_FW_NAME="$(copy_to_firmware "$OVERLAY_PATH")"
fi

program_fpga "$BITSTREAM_FW_NAME"

if [[ -n "$OVERLAY_PATH" ]]; then
    ensure_configfs

    if [[ "$FORCE_RELOAD" == true ]]; then
        remove_existing_overlay "$OVERLAY_NAME"
    fi

    load_overlay "$OVERLAY_NAME" "$OVERLAY_FW_NAME"
fi

if [[ -n "$MODULE_PATH" ]]; then
    load_kernel_module "$MODULE_PATH"
fi

echo
echo "========================================================"
echo "DONE"
echo "========================================================"
echo