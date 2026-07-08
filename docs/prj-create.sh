#!/usr/bin/env bash

###############################################################################
# PetaLinux Project Automation Script
###############################################################################
#
# Usage examples:
#   ./prj_create.sh -xsa /path/to/design.xsa -bit /path/to/design.bit
#   ./prj_create.sh -xsa /path/to/design.xsa -bit /path/to/design.bit -n DCCT_v2.1
#
###############################################################################

set -euo pipefail

###############################################################################
# Defaults / command-line options
###############################################################################
XSA_PATH=""
BIT_PATH=""
PROJECT_NAME=""

usage() {
    echo "Usage:"
    echo "  $0 -xsa path_to_xsa_file [-bit path_to_bit_file] [-n project_name]"
    echo
    echo "Options:"
    echo "  -xsa PATH     Path to Vivado-exported XSA file"
    echo "  -bit PATH     Path to FPGA bitstream .bit file"
    echo "  -n NAME       PetaLinux project name"
    echo "  -h, --help    Show this help"
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -xsa)
            if [[ $# -lt 2 ]]; then
                echo "ERROR: Missing argument for -xsa"
                usage
                exit 1
            fi
            XSA_PATH="$2"
            shift 2
            ;;
        -bit)
            if [[ $# -lt 2 ]]; then
                echo "ERROR: Missing argument for -bit"
                usage
                exit 1
            fi
            BIT_PATH="$2"
            shift 2
            ;;
        -n)
            if [[ $# -lt 2 ]]; then
                echo "ERROR: Missing argument for -n"
                usage
                exit 1
            fi
            PROJECT_NAME="$2"
            shift 2
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "ERROR: Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

###############################################################################
# Functions
###############################################################################
check_requirements() {
    echo
    echo "Checking PetaLinux environment..."

    if ! command -v petalinux-create >/dev/null 2>&1; then
        echo "ERROR: PetaLinux tools not found in PATH."
        echo "Verify that settings.sh has been sourced correctly."
        exit 1
    fi

    echo "PetaLinux tools detected."
    echo
}

prompt_for_file() {
    local label="$1"
    local file=""

    while true; do
        printf "Enter full path to %s: " "$label" >&2

        if ! IFS= read -r file; then
            echo "ERROR: No input provided." >&2
            exit 1
        fi

        if [[ -f "$file" ]]; then
            printf '%s\n' "$file"
            return 0
        fi

        echo "ERROR: File not found." >&2
    done
}

check_file_exists() {
    local file="$1"

    if [[ ! -f "$file" ]]; then
        echo "ERROR: Missing required file:"
        echo "  $file"
        exit 1
    fi
}

validate_xsa() {
    local file="$1"

    if [[ ! -f "$file" ]]; then
        echo "ERROR: XSA file not found:"
        echo "  $file"
        exit 1
    fi

    if [[ "${file##*.}" != "xsa" ]]; then
        echo "ERROR: File does not look like an XSA file:"
        echo "  $file"
        exit 1
    fi
}

validate_bit() {
    local file="$1"

    if [[ ! -f "$file" ]]; then
        echo "ERROR: BIT file not found:"
        echo "  $file"
        exit 1
    fi

    if [[ "${file##*.}" != "bit" ]]; then
        echo "ERROR: File does not look like a .bit file:"
        echo "  $file"
        exit 1
    fi
}

install_bitstream_recipe() {
    local src_bit="$1"
    local bit_base
    local dest_dir
    local recipe_dir

    bit_base="$(basename "$src_bit")"
    dest_dir="project-spec/meta-user/recipes-bsp/bitstream/files"
    recipe_dir="project-spec/meta-user/recipes-bsp/bitstream"

    echo
    echo "Installing bitstream into meta-user recipe:"
    echo "  $src_bit"

    mkdir -p "$dest_dir"
    cp -f "$src_bit" "$dest_dir/$bit_base"

    cat > "$recipe_dir/bitstream.bb" <<EOF_RECIPE
SUMMARY = "FPGA bitstream"
LICENSE = "CLOSED"

SRC_URI = "file://$bit_base"

S = "\${WORKDIR}"

do_install() {
    install -d \${D}/boot/bitstream
    install -m 0644 \${WORKDIR}/$bit_base \${D}/boot/bitstream/$bit_base
}

FILES:\${PN} += "/boot/bitstream/$bit_base"
EOF_RECIPE

    echo "Bitstream recipe written:"
    echo "  $recipe_dir/bitstream.bb"
    echo
}

###############################################################################
# Script location
###############################################################################
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo
echo "Script directory:"
echo "  $SCRIPT_DIR"
echo

###############################################################################
# Source PetaLinux settings
###############################################################################
if [[ ! -f "$SCRIPT_DIR/settings.sh" ]]; then
    echo "ERROR: settings.sh not found."
    echo "Expected:"
    echo "  $SCRIPT_DIR/settings.sh"
    exit 1
fi

echo "Sourcing PetaLinux settings..."

# settings.sh must not receive this script's arguments such as -xsa or -bit.
ORIGINAL_ARGS=("$@")
set --
source "$SCRIPT_DIR/settings.sh"
set -- "${ORIGINAL_ARGS[@]}"

check_requirements

###############################################################################
# Locate BSP automatically
###############################################################################
mapfile -t BSP_FILES < <(find "$SCRIPT_DIR" -maxdepth 1 -name "*.bsp")

if [[ ${#BSP_FILES[@]} -eq 0 ]]; then
    echo "ERROR: No BSP file found in:"
    echo "  $SCRIPT_DIR"
    exit 1
fi

if [[ ${#BSP_FILES[@]} -gt 1 ]]; then
    echo "ERROR: Multiple BSP files found:"
    printf '  %s\n' "${BSP_FILES[@]}"
    exit 1
fi

BSP_PATH="${BSP_FILES[0]}"
echo "Using BSP:"
echo "  $BSP_PATH"
echo

###############################################################################
# Project name
###############################################################################
if [[ -z "$PROJECT_NAME" ]]; then
    read -r -p "Enter PetaLinux project name: " PROJECT_NAME
fi

if [[ -z "$PROJECT_NAME" ]]; then
    echo "ERROR: Project name cannot be empty."
    exit 1
fi

RESUME_PROJECT=false

if [[ -e "$PROJECT_NAME" ]]; then
    if [[ -d "$PROJECT_NAME/project-spec" ]]; then
        echo "Project directory already exists:"
        echo "  $PROJECT_NAME"
        read -r -p "Resume existing project? [y/N]: " RESUME_ANSWER

        if [[ "$RESUME_ANSWER" =~ ^[Yy]$ ]]; then
            RESUME_PROJECT=true
        else
            echo "Aborted."
            exit 1
        fi
    else
        echo "ERROR: Path already exists but does not look like a PetaLinux project:"
        echo "  $PROJECT_NAME"
        exit 1
    fi
fi

###############################################################################
# Validate input files if provided
###############################################################################
if [[ -n "$XSA_PATH" ]]; then
    validate_xsa "$XSA_PATH"
    XSA_PATH="$(realpath "$XSA_PATH")"
fi

if [[ -n "$BIT_PATH" ]]; then
    validate_bit "$BIT_PATH"
    BIT_PATH="$(realpath "$BIT_PATH")"
fi

###############################################################################
# Create project
###############################################################################
if [[ "$RESUME_PROJECT" == false ]]; then
    echo
    echo "Creating project..."

    petalinux-create \
        --type project \
        --name "$PROJECT_NAME" \
        -s "$BSP_PATH"

    echo "Project created."
    echo
else
    echo
    echo "Resuming existing project."
    echo
fi

cd "$PROJECT_NAME"

###############################################################################
# Hardware description import
###############################################################################
if [[ "$RESUME_PROJECT" == false ]]; then

    if [[ -z "$XSA_PATH" ]]; then
        while true; do
            read -r -p "Enter path to the XSA file: " XSA_PATH

            if [[ -f "$XSA_PATH" && "${XSA_PATH##*.}" == "xsa" ]]; then
                XSA_PATH="$(realpath "$XSA_PATH")"
                break
            fi

            echo "ERROR: XSA file not found."
        done
    fi

    XSA_DIR="$(dirname "$XSA_PATH")"

    echo
    echo "Using XSA:"
    echo "  $XSA_PATH"
    echo

    echo "Importing hardware description..."
    petalinux-config --get-hw-description="$XSA_DIR"
    echo "Hardware configuration completed."
    echo
else
    echo
    echo "Skipping hardware import in resume mode."
    echo
fi

###############################################################################
# Bitstream recipe for fpga-manager-util
###############################################################################
if [[ -z "$BIT_PATH" ]]; then
    echo
    echo "No bitstream provided with -bit."
    echo "A .bit file is required if fpga-manager-util is enabled."
    BIT_PATH="$(prompt_for_file "FPGA bitstream (.bit file)")"
    validate_bit "$BIT_PATH"
    BIT_PATH="$(realpath "$BIT_PATH")"
fi

install_bitstream_recipe "$BIT_PATH"

###############################################################################
# First build
###############################################################################
if [[ "$RESUME_PROJECT" == false ]]; then
    echo "Running initial build..."
    petalinux-build
    echo "Initial build completed."
    echo
else
    echo "Skipping initial build in resume mode."
    echo
fi

###############################################################################
# RootFS configuration
###############################################################################
read -r -p "Open RootFS configuration menu? [y/N]: " OPEN_ROOTFS_CONFIG

if [[ "$OPEN_ROOTFS_CONFIG" =~ ^[Yy]$ ]]; then
    echo "Opening RootFS configuration..."
    petalinux-config -c rootfs
    echo "RootFS configuration completed."
    echo
else
    echo "Skipping RootFS configuration."
    echo
fi

###############################################################################
# Clean fpga-manager-util after bitstream recipe update
###############################################################################
echo "Cleaning fpga-manager-util state after bitstream recipe update..."
petalinux-build -c fpga-manager-util -x cleansstate || true

###############################################################################
# Final build
###############################################################################
echo "Running final build..."
petalinux-build
echo "Final build completed."
echo

###############################################################################
# Verify generated files
###############################################################################
IMAGES_DIR="images/linux"

check_file_exists "$IMAGES_DIR/Image"
check_file_exists "$IMAGES_DIR/system.dtb"
check_file_exists "$IMAGES_DIR/boot.scr"

###############################################################################
# BOOT.BIN packaging
###############################################################################
FSBL_PATH=""

for fsbl in "$IMAGES_DIR"/*fsbl*.elf; do
    if [[ -f "$fsbl" ]]; then
        FSBL_PATH="$fsbl"
        break
    fi
done

if [[ -z "$FSBL_PATH" ]]; then
    echo "WARNING: No FSBL found in $IMAGES_DIR"
    FSBL_PATH="$(prompt_for_file "FSBL ELF file")"
else
    echo "Using FSBL:"
    echo "  $FSBL_PATH"
fi

echo
 echo "Using bitstream for BOOT.BIN:"
echo "  $BIT_PATH"

echo
echo "Generating BOOT.BIN..."

petalinux-package --boot \
    --fsbl "$FSBL_PATH" \
    --fpga "$BIT_PATH" \
    --u-boot \
    --force

echo "BOOT.BIN generated."
echo

###############################################################################
# Build bootfile list automatically
###############################################################################
BOOTFILES="BOOT.BIN,boot.scr,Image,system.dtb"

if [[ -f "$IMAGES_DIR/rootfs.cpio.gz.u-boot" ]]; then
    BOOTFILES="$BOOTFILES,rootfs.cpio.gz.u-boot"
fi

if [[ -f "$IMAGES_DIR/ramdisk.cpio.gz.u-boot" ]]; then
    BOOTFILES="$BOOTFILES,ramdisk.cpio.gz.u-boot"
fi

###############################################################################
# Optional extra DTB
###############################################################################
read -r -p "Additional DTB filename in images/linux (press ENTER to skip): " EXTRA_DTB

if [[ -n "$EXTRA_DTB" ]]; then
    if [[ ! -f "$IMAGES_DIR/$EXTRA_DTB" ]]; then
        echo "ERROR: DTB not found:"
        echo "  $IMAGES_DIR/$EXTRA_DTB"
        exit 1
    fi

    BOOTFILES="$BOOTFILES,$EXTRA_DTB"
fi

###############################################################################
# WIC packaging
###############################################################################
echo
echo "Generating WIC image..."

petalinux-package --wic \
    --images-dir "$IMAGES_DIR" \
    --bootfiles "$BOOTFILES" \
    --disk-name sda

echo "WIC image generated."
echo

###############################################################################
# Summary
###############################################################################
BOOT_BIN="$IMAGES_DIR/BOOT.BIN"
WIC_FILE="$IMAGES_DIR/petalinux-sdimage.wic"

echo
echo "========================================================"
echo "BUILD COMPLETED SUCCESSFULLY"
echo "========================================================"
echo

if [[ -f "$BOOT_BIN" ]]; then
    echo "BOOT.BIN:"
    echo "  $(pwd)/$BOOT_BIN"
    echo
fi

if [[ -f "$WIC_FILE" ]]; then
    echo "WIC IMAGE:"
    echo "  $(pwd)/$WIC_FILE"
    echo
else
    echo "WARNING: WIC image not found."
fi

echo "Done."
