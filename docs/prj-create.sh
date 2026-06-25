#!/usr/bin/env bash

###############################################################################
# PetaLinux Project Automation Script
###############################################################################
#
# Description:
#   This script automates the creation, configuration, build and packaging of a
#   PetaLinux project starting from a BSP file and a Vivado-exported XSA hardware
#   description.
#
#   The script is intended for a workflow in which:
#     - settings.sh is located in the same directory as this script;
#     - exactly one .bsp file is located in the same directory as this script;
#     - the XSA file is provided by entering the directory that contains it;
#     - the FSBL ELF file is searched automatically inside images/linux;
#     - the FPGA bitstream is provided manually by the user;
#     - BOOT.BIN and a bootable WIC image are generated at the end.
#
# Main features:
#   1. Sources the local PetaLinux settings.sh file.
#   2. Checks that the PetaLinux tools are available in the environment.
#   3. Automatically detects the BSP file in the script directory.
#   4. Creates a new PetaLinux project, or resumes an existing one.
#   5. Imports the hardware description from the provided XSA directory.
#   6. Runs an initial build for newly created projects.
#   7. Optionally opens the RootFS configuration menu.
#   8. Runs the final PetaLinux build.
#   9. Checks that the required boot files have been generated.
#  10. Searches automatically for an FSBL ELF file in images/linux.
#  11. Packages BOOT.BIN using the FSBL, bitstream and U-Boot.
#  12. Builds the WIC image for SD-card boot.
#
# Resume mode:
#   If the project directory already exists and contains project-spec, the script
#   can resume the existing project instead of creating it again. In resume mode,
#   the hardware import and the initial build are skipped, while the RootFS
#   configuration, final build and packaging steps can still be executed.
#
# Notes:
#   - PetaLinux/Yocto builds are incremental, so after a failed build it is often
#     sufficient to fix the configuration and rerun petalinux-build.
#   - If the build fails during do_rootfs, reopen the RootFS menu and check for
#     conflicting packages, such as OpenSSH and Dropbear being enabled together.
#   - The optional extra DTB prompt can be used to include board-specific DTB
#     files in the WIC boot partition when required by the BSP.
#
###############################################################################

set -euo pipefail


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
source "$SCRIPT_DIR/settings.sh"
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
read -r -p "Enter PetaLinux project name: " PROJECT_NAME
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

    while true; do

        read -r -p "Enter directory containing the XSA file: " XSA_DIR

        if [[ -d "$XSA_DIR" ]]; then
            break
        fi

        echo "ERROR: Directory not found."
    done

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
BIT_PATH="$(prompt_for_file "FPGA bitstream (.bit file)")"
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
read -r -p \
"Additional DTB filename in images/linux (press ENTER to skip): " \
EXTRA_DTB
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