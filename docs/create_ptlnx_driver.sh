#!/usr/bin/env bash

set -euo pipefail

usage() {
    echo "Usage:"
    echo "  $0 -n <drivername> -source <path_to_file_py> -fifo <fifo_name>"
    echo ""
    echo "Options:"
    echo "  -n       Driver name"
    echo "  -source  Path to the Python source file"
    echo "  -fifo    FIFO name"
    echo "  -h       Show this help message"
    echo "  --help   Show this help message"
}


DRIVER_NAME=""
SOURCE_PY=""
FIFO_NAME=""

PL_DTSI_FILE="./components/plnx_workspace/device-tree/device-tree/pl.dtsi"


while [[ $# -gt 0 ]]; do

    case "$1" in

        -n)
            [[ $# -ge 2 ]] || {
                echo "Error: missing value for -n." >&2
                usage
                exit 1
            }

            DRIVER_NAME="$2"
            shift 2
            ;;


        -source)
            [[ $# -ge 2 ]] || {
                echo "Error: missing value for -source." >&2
                usage
                exit 1
            }

            SOURCE_PY="$2"
            shift 2
            ;;


        -fifo)
            [[ $# -ge 2 ]] || {
                echo "Error: missing value for -fifo." >&2
                usage
                exit 1
            }

            FIFO_NAME="$2"
            shift 2
            ;;


        -h|--help)
            usage
            exit 0
            ;;


        *)
            echo "Error: unknown argument: $1" >&2
            usage
            exit 1
            ;;

    esac

done



###############################################################################
# Check mandatory arguments
###############################################################################

if [[ -z "$DRIVER_NAME" || -z "$SOURCE_PY" || -z "$FIFO_NAME" ]]; then

    echo "Error: one or more mandatory arguments are missing." >&2
    usage
    exit 1

fi



###############################################################################
# Check PetaLinux environment
###############################################################################

PETALINUX_CREATE_BIN="$(command -v petalinux-create || true)"
PETALINUX_BUILD_BIN="$(command -v petalinux-build || true)"


if [[ -z "$PETALINUX_CREATE_BIN" ]]; then

    echo "Error: petalinux-create was not found in PATH." >&2
    echo "Source the PetaLinux environment first." >&2
    echo ""
    echo "Example:"
    echo "source /opt/petalinux/2022.2/settings.sh"
    exit 1

fi


if [[ -z "$PETALINUX_BUILD_BIN" ]]; then

    echo "Error: petalinux-build was not found in PATH." >&2
    exit 1

fi



###############################################################################
# Check PetaLinux project root
###############################################################################

if [[ ! -d "./project-spec" ]]; then

    echo "Error: project-spec directory not found." >&2
    echo "Run this script from the PetaLinux project root." >&2
    exit 1

fi



###############################################################################
# Validate driver name
###############################################################################

if [[ ! "$DRIVER_NAME" =~ ^[A-Za-z0-9][A-Za-z0-9_-]*$ ]]; then

    echo "Error: invalid driver name: $DRIVER_NAME" >&2
    echo "Allowed characters:"
    echo "letters, numbers, '_' and '-'."
    exit 1

fi



###############################################################################
# Check Python generator
###############################################################################

if [[ ! -f "$SOURCE_PY" ]]; then

    echo "Error: Python source file does not exist:"
    echo "$SOURCE_PY"
    exit 1

fi


if [[ "${SOURCE_PY##*.}" != "py" ]]; then

    echo "Error: source file must be .py:"
    echo "$SOURCE_PY"
    exit 1

fi



###############################################################################
# Check PL device tree
###############################################################################

if [[ ! -f "$PL_DTSI_FILE" ]]; then

    echo "Error: pl.dtsi not found:"
    echo "  $PL_DTSI_FILE"
    exit 1

fi



###############################################################################
# Python interpreter
###############################################################################

PYTHON_BIN="$(command -v python3 || command -v python || true)"


if [[ -z "$PYTHON_BIN" ]]; then

    echo "Error: Python interpreter not found."
    exit 1

fi



###############################################################################
# Resolve paths
###############################################################################

SOURCE_PY_ABS="$(realpath "$SOURCE_PY")"

PL_DTSI_FILE_ABS="$(realpath "$PL_DTSI_FILE")"

SOURCE_DIR="$(dirname "$SOURCE_PY_ABS")"

PROJECT_ROOT="$(pwd)"



###############################################################################
# Search templates
###############################################################################

mapfile -d '' TEMPLATE_FILES < <(
    find "$SOURCE_DIR" \
        -maxdepth 1 \
        -type f \
        -name '*.template' \
        -print0
)


if [[ ${#TEMPLATE_FILES[@]} -ne 2 ]]; then

    echo "Error: exactly two template files are required."
    echo ""
    echo "Directory checked:"
    echo "$SOURCE_DIR"
    echo ""
    echo "Templates found:"
    echo "${#TEMPLATE_FILES[@]}"

    exit 1

fi



###############################################################################
# Driver paths
###############################################################################

DRIVER_MODULE_DIR="$PROJECT_ROOT/project-spec/meta-user/recipes-modules/$DRIVER_NAME"

DRIVER_FILES_DIR="$DRIVER_MODULE_DIR/files"



echo ""
echo "Driver name        : $DRIVER_NAME"
echo "Python generator   : $SOURCE_PY_ABS"
echo "PL DTSI            : $PL_DTSI_FILE_ABS"
echo "FIFO name          : $FIFO_NAME"
echo "Project root       : $PROJECT_ROOT"
echo "Driver directory   : $DRIVER_MODULE_DIR"
echo ""



###############################################################################
# Create kernel module
###############################################################################

if [[ -d "$DRIVER_MODULE_DIR" ]]; then

    echo "Kernel module already exists."
    echo "Skipping petalinux-create."

else

    echo "Creating PetaLinux kernel module..."

    "$PETALINUX_CREATE_BIN" \
        -t modules \
        --name "$DRIVER_NAME" \
        --enable


    echo "Kernel module created."

fi



###############################################################################
# Check module directory
###############################################################################

if [[ ! -d "$DRIVER_FILES_DIR" ]]; then

    echo "Error: module files directory missing:"
    echo "$DRIVER_FILES_DIR"
    exit 1

fi


###############################################################################
# Copy generator and templates into project root
###############################################################################

SOURCE_PY_NAME="$(basename "$SOURCE_PY_ABS")"

COPIED_SOURCE_PY="$PROJECT_ROOT/$SOURCE_PY_NAME"



copy_if_needed()
{
    local source_file="$1"
    local destination_file="$2"

    local source_abs
    local destination_abs


    source_abs="$(realpath "$source_file")"
    destination_abs="$(realpath -m "$destination_file")"


    if [[ "$source_abs" == "$destination_abs" ]]; then

        echo "Already present:"
        echo "  $destination_file"

    else

        cp -- "$source_file" "$destination_file"

        echo "Copied:"
        echo "  $source_file"
        echo "  -> $destination_file"

    fi
}



copy_if_needed \
    "$SOURCE_PY_ABS" \
    "$COPIED_SOURCE_PY"



for template_file in "${TEMPLATE_FILES[@]}"; do

    template_name="$(basename "$template_file")"


    copy_if_needed \
        "$template_file" \
        "$PROJECT_ROOT/$template_name"

done



echo ""
echo "Generator files copied."
echo ""



###############################################################################
# Run Python generator
###############################################################################

echo "Running Python generator:"
echo ""
echo "Driver:"
echo "  $DRIVER_NAME"
echo ""
echo "DTSI:"
echo "  $PL_DTSI_FILE_ABS"
echo ""
echo "FIFO:"
echo "  $FIFO_NAME"
echo ""



if (
    cd "$PROJECT_ROOT"


    "$PYTHON_BIN" \
        "$COPIED_SOURCE_PY" \
        "$DRIVER_NAME" \
        "$PL_DTSI_FILE_ABS" \
        "$FIFO_NAME"

)
then

    echo ""
    echo "Python generator completed successfully."

else

    RETVAL=$?


    echo ""
    echo "Python generator failed."
    echo "Return code: $RETVAL"

    exit "$RETVAL"

fi




###############################################################################
# Locate generated driver files
###############################################################################

DRIVER_NAME_LOWER="${DRIVER_NAME,,}"


GENERATED_SOURCE="$PROJECT_ROOT/${DRIVER_NAME_LOWER}.c"

GENERATED_HEADER="$PROJECT_ROOT/${DRIVER_NAME_LOWER}.h"



if [[ ! -f "$GENERATED_SOURCE" ]]; then

    echo "Error: generated source file not found:"
    echo "$GENERATED_SOURCE"

    exit 1

fi



if [[ ! -f "$GENERATED_HEADER" ]]; then

    echo "Error: generated header file not found:"
    echo "$GENERATED_HEADER"

    exit 1

fi



###############################################################################
# Copy driver files into PetaLinux module
###############################################################################

echo ""
echo "Copying generated driver files..."
echo ""



cp -f \
    "$GENERATED_SOURCE" \
    "$DRIVER_FILES_DIR/${DRIVER_NAME}.c"



cp -f \
    "$GENERATED_HEADER" \
    "$DRIVER_FILES_DIR/${DRIVER_NAME}.h"



echo "Driver files installed:"
echo ""
echo "  $DRIVER_FILES_DIR/${DRIVER_NAME}.c"
echo "  $DRIVER_FILES_DIR/${DRIVER_NAME}.h"
echo ""



###############################################################################
# Update Makefile
###############################################################################

MAKEFILE="$DRIVER_FILES_DIR/Makefile"


if [[ ! -f "$MAKEFILE" ]]; then

    echo "Error: Makefile not found:"
    echo "$MAKEFILE"

    exit 1

fi



INCLUDE_OPTION="-I$DRIVER_FILES_DIR"



echo "Updating Makefile..."



if grep -Fq -- "$INCLUDE_OPTION" "$MAKEFILE"; then

    echo "Include path already present."

else


    if grep -Eq '^[[:space:]]*MY_CFLAGS[[:space:]]*\+=' "$MAKEFILE"; then


        sed -i \
            "/^[[:space:]]*MY_CFLAGS[[:space:]]*+=/ s|\$| $INCLUDE_OPTION|" \
            "$MAKEFILE"


    else


        echo "MY_CFLAGS += -g -DDEBUG $INCLUDE_OPTION" \
            >> "$MAKEFILE"


    fi


fi



echo ""
echo "Current MY_CFLAGS:"
grep -E '^[[:space:]]*MY_CFLAGS[[:space:]]*\+=' "$MAKEFILE" || true

echo ""



###############################################################################
# Build kernel module
###############################################################################

echo ""
echo "Building PetaLinux module:"
echo "  $DRIVER_NAME"
echo ""



if "$PETALINUX_BUILD_BIN" -c "$DRIVER_NAME"; then


    echo ""
    echo "Kernel module built successfully."


else


    RETVAL=$?


    echo ""
    echo "petalinux-build failed."
    echo "Return code: $RETVAL"

    exit "$RETVAL"


fi




###############################################################################
# Create wrapper directory
###############################################################################

echo ""

echo "Creating wrapper directory..."



WRAPPER_DIR="$PROJECT_ROOT/${DRIVER_NAME}_wrapper"



if [[ -e "$WRAPPER_DIR" && ! -d "$WRAPPER_DIR" ]]; then

    echo "Error: wrapper path exists and is not a directory:"
    echo "$WRAPPER_DIR"

    exit 1

fi



mkdir -p "$WRAPPER_DIR"



echo "Wrapper:"
echo "  $WRAPPER_DIR"
echo ""



###############################################################################
# Locate kernel module
###############################################################################

KO_SEARCH_ROOT="$PROJECT_ROOT/build/tmp/sysroots-components/xilinx_k26_kr/$DRIVER_NAME"



KO_FILE="$KO_SEARCH_ROOT/lib/modules/5.15.36-xilinx-v2022.2/extra/${DRIVER_NAME}.ko"



if [[ ! -f "$KO_FILE" ]]; then


    KO_FILE="$(
        find "$KO_SEARCH_ROOT" \
            -type f \
            -name "${DRIVER_NAME}.ko" \
            -print \
            -quit 2>/dev/null || true
    )"


fi



if [[ -z "$KO_FILE" || ! -f "$KO_FILE" ]]; then


    echo "Error: kernel module not found:"
    echo "$DRIVER_NAME.ko"

    exit 1


fi



cp -f \
    "$KO_FILE" \
    "$WRAPPER_DIR/${DRIVER_NAME}.ko"



echo "Kernel module copied:"
echo "  $WRAPPER_DIR/${DRIVER_NAME}.ko"



###############################################################################
# Copy generated source and header into wrapper
###############################################################################

DRIVER_SOURCE_FILE="$DRIVER_FILES_DIR/${DRIVER_NAME}.c"

DRIVER_HEADER_FILE="$DRIVER_FILES_DIR/${DRIVER_NAME}.h"



if [[ ! -f "$DRIVER_SOURCE_FILE" ]]; then

    echo "Error: driver source file not found:"
    echo "$DRIVER_SOURCE_FILE"

    exit 1

fi



if [[ ! -f "$DRIVER_HEADER_FILE" ]]; then

    echo "Error: driver header file not found:"
    echo "$DRIVER_HEADER_FILE"

    exit 1

fi



cp -f \
    "$DRIVER_SOURCE_FILE" \
    "$WRAPPER_DIR/"



cp -f \
    "$DRIVER_HEADER_FILE" \
    "$WRAPPER_DIR/"



echo ""
echo "Driver source/header copied into wrapper."
echo ""



###############################################################################
# Copy programmable logic device-tree overlay into wrapper
###############################################################################

echo "Copying programmable-logic device-tree overlay..."
echo ""

PL_DTBO_FILE="$PROJECT_ROOT/images/linux/pl.dtbo"

if [[ ! -f "$PL_DTBO_FILE" ]]; then

    echo "Error: pl.dtbo not found:"
    echo "  $PL_DTBO_FILE"
    echo ""
    echo "Generate it before running this script, for example with:"
    echo "  petalinux-build -c device-tree"

    exit 1

fi

if [[ ! -s "$PL_DTBO_FILE" ]]; then

    echo "Error: pl.dtbo exists but is empty:"
    echo "  $PL_DTBO_FILE"

    exit 1

fi

cp -f \
    "$PL_DTBO_FILE" \
    "$WRAPPER_DIR/pl.dtbo"

echo "DTBO copied:"
echo "  $WRAPPER_DIR/pl.dtbo"
echo ""


###############################################################################
# Locate WIC image
###############################################################################

echo "Searching WIC image..."
echo ""



WIC_FILE=""



# First search inside module directory

WIC_FILE="$(
    find "$DRIVER_FILES_DIR" \
        -maxdepth 1 \
        -type f \
        -name '*.wic' \
        -print \
        -quit 2>/dev/null || true
)"



# Then search standard PetaLinux output

if [[ -z "$WIC_FILE" ]]; then


    WIC_FILE="$(
        find "$PROJECT_ROOT/images/linux" \
            -maxdepth 1 \
            -type f \
            -name '*.wic' \
            -print \
            -quit 2>/dev/null || true
    )"


fi



if [[ -z "$WIC_FILE" || ! -f "$WIC_FILE" ]]; then

    echo "Error: no WIC image found."

    echo ""
    echo "Checked:"
    echo "  $DRIVER_FILES_DIR"
    echo "  $PROJECT_ROOT/images/linux"

    exit 1

fi



cp -f \
    "$WIC_FILE" \
    "$WRAPPER_DIR/"



echo "WIC image copied:"
echo "  $(basename "$WIC_FILE")"

echo ""



###############################################################################
# Final report
###############################################################################

echo ""
echo "================================================"
echo "Driver creation completed successfully"
echo "================================================"
echo ""

echo "Wrapper directory:"
echo "  $WRAPPER_DIR"

echo ""

echo "Wrapper contents:"
echo ""

ls -lh "$WRAPPER_DIR"


echo ""

echo "Generated files:"
echo ""

echo "  Kernel module:"
echo "    ${DRIVER_NAME}.ko"

echo ""

echo "  Device tree:"
echo "    pl.dtbo"

echo ""

echo "  Driver sources:"
echo "    ${DRIVER_NAME}.c"
echo "    ${DRIVER_NAME}.h"

echo ""

echo "  Boot image:"
echo "    $(basename "$WIC_FILE")"

echo ""

echo "Done."