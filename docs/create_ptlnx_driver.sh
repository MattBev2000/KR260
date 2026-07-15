#!/usr/bin/env bash

set -euo pipefail

usage() {
    echo "Usage:"
    echo "  $0 -n <drivername> -source <path_to_file_py> [-dtsi <path_to_dtsi>] -fifo <fifo_name>"
    echo ""
    echo "Options:"
    echo "  -n       Driver name"
    echo "  -source  Path to the Python source file"
    echo "  -dtsi    Path to the DTSI file"
    echo "           Optional. Default:"
    echo "           ./components/plnx_workspace/device-tree/device-tree/pl.dtsi"
    echo "  -fifo    FIFO name"
    echo "  -h       Show this help message"
    echo "  --help   Show this help message"
}

DRIVER_NAME=""
SOURCE_PY=""
DTSI_FILE=""
FIFO_NAME=""

DEFAULT_DTSI_PATH="./components/plnx_workspace/device-tree/device-tree/pl.dtsi"

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

        -dtsi)
            [[ $# -ge 2 ]] || {
                echo "Error: missing value for -dtsi." >&2
                usage
                exit 1
            }

            DTSI_FILE="$2"
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

# Check mandatory arguments.
# The DTSI argument is optional.
if [[ -z "$DRIVER_NAME" || -z "$SOURCE_PY" || -z "$FIFO_NAME" ]]; then
    echo "Error: one or more mandatory arguments are missing." >&2
    usage
    exit 1
fi

# Always check the PetaLinux environment.
PETALINUX_CREATE_BIN="$(command -v petalinux-create || true)"
PETALINUX_BUILD_BIN="$(command -v petalinux-build || true)"

if [[ -z "$PETALINUX_CREATE_BIN" ]]; then
    echo "Error: petalinux-create was not found in PATH." >&2
    echo "Source the PetaLinux environment before running this script." >&2
    echo "" >&2
    echo "Example:" >&2
    echo "  source /opt/petalinux/2022.2/settings.sh" >&2
    exit 1
fi

if [[ -z "$PETALINUX_BUILD_BIN" ]]; then
    echo "Error: petalinux-build was not found in PATH." >&2
    echo "Source the PetaLinux environment before running this script." >&2
    exit 1
fi

# Check that the script is running from a PetaLinux project root.
if [[ ! -d "./project-spec" ]]; then
    echo "Error: project-spec directory not found." >&2
    echo "Run this script from the root directory of the PetaLinux project." >&2
    exit 1
fi

# Validate the driver name.
if [[ ! "$DRIVER_NAME" =~ ^[A-Za-z0-9][A-Za-z0-9_-]*$ ]]; then
    echo "Error: invalid driver name: $DRIVER_NAME" >&2
    echo "Use only letters, numbers, underscores, and hyphens." >&2
    exit 1
fi

# Check the Python source file.
if [[ ! -f "$SOURCE_PY" ]]; then
    echo "Error: Python source file does not exist:" >&2
    echo "  $SOURCE_PY" >&2
    exit 1
fi

if [[ "${SOURCE_PY##*.}" != "py" ]]; then
    echo "Error: the source file must have a .py extension:" >&2
    echo "  $SOURCE_PY" >&2
    exit 1
fi

# Use the default pl.dtsi file when -dtsi is not provided.
if [[ -z "$DTSI_FILE" ]]; then
    DTSI_FILE="$DEFAULT_DTSI_PATH"

    echo ""
    echo "No DTSI file was specified."
    echo "Looking for the default pl.dtsi file:"
    echo "  $DTSI_FILE"
fi

# Check the DTSI file.
if [[ ! -f "$DTSI_FILE" ]]; then
    echo "Error: DTSI file does not exist:" >&2
    echo "  $DTSI_FILE" >&2
    exit 1
fi

# Locate an available Python interpreter.
PYTHON_BIN="$(command -v python3 || command -v python || true)"

if [[ -z "$PYTHON_BIN" ]]; then
    echo "Error: no Python interpreter was found." >&2
    echo "Install Python or make python3/python available in PATH." >&2
    exit 1
fi

# Resolve absolute paths.
SOURCE_PY_ABS="$(realpath "$SOURCE_PY")"
DTSI_FILE_ABS="$(realpath "$DTSI_FILE")"
SOURCE_DIR="$(dirname "$SOURCE_PY_ABS")"
PROJECT_ROOT="$(pwd)"

# Find all .template files in the Python source directory.
mapfile -d '' TEMPLATE_FILES < <(
    find "$SOURCE_DIR" \
        -maxdepth 1 \
        -type f \
        -name '*.template' \
        -print0
)

# Exactly two template files are required.
if [[ ${#TEMPLATE_FILES[@]} -ne 2 ]]; then
    echo "Error: exactly two .template files must be present" >&2
    echo "in the Python source directory." >&2
    echo "" >&2
    echo "Checked directory: $SOURCE_DIR" >&2
    echo "Templates found  : ${#TEMPLATE_FILES[@]}" >&2
    exit 1
fi

# PetaLinux module paths.
DRIVER_MODULE_DIR="$PROJECT_ROOT/project-spec/meta-user/recipes-modules/$DRIVER_NAME"
DRIVER_FILES_DIR="$DRIVER_MODULE_DIR/files"

echo ""
echo "Driver name        : $DRIVER_NAME"
echo "Python file        : $SOURCE_PY_ABS"
echo "DTSI file          : $DTSI_FILE_ABS"
echo "FIFO name          : $FIFO_NAME"
echo "Project root       : $PROJECT_ROOT"
echo "Driver directory   : $DRIVER_MODULE_DIR"
echo "Template file #1   : ${TEMPLATE_FILES[0]}"
echo "Template file #2   : ${TEMPLATE_FILES[1]}"
echo "petalinux-create   : $PETALINUX_CREATE_BIN"
echo "petalinux-build    : $PETALINUX_BUILD_BIN"
echo "Python interpreter : $PYTHON_BIN"
echo ""

# Create the PetaLinux module only if it does not already exist.
if [[ -d "$DRIVER_MODULE_DIR" ]]; then
    echo "PetaLinux kernel module '$DRIVER_NAME' already exists."
    echo "Skipping petalinux-create."
    echo ""
else
    echo "Creating PetaLinux kernel module '$DRIVER_NAME'..."
    echo ""

    "$PETALINUX_CREATE_BIN" \
        -t modules \
        --name "$DRIVER_NAME" \
        --enable

    echo ""
    echo "PetaLinux kernel module created successfully."
    echo ""
fi

# Ensure that the module files directory exists.
if [[ ! -d "$DRIVER_FILES_DIR" ]]; then
    echo "Error: PetaLinux module files directory does not exist:" >&2
    echo "  $DRIVER_FILES_DIR" >&2
    exit 1
fi

# Copy the Python generator and templates into the project root.
SOURCE_PY_NAME="$(basename "$SOURCE_PY_ABS")"
COPIED_SOURCE_PY="$PROJECT_ROOT/$SOURCE_PY_NAME"

copy_if_needed() {
    local source_file="$1"
    local destination_file="$2"
    local source_abs
    local destination_abs

    source_abs="$(realpath "$source_file")"
    destination_abs="$(realpath -m "$destination_file")"

    if [[ "$source_abs" == "$destination_abs" ]]; then
        echo "File already in destination: $source_file"
    else
        cp -- "$source_file" "$destination_file"
        echo "Copied: $source_file"
    fi
}

copy_if_needed "$SOURCE_PY_ABS" "$COPIED_SOURCE_PY"

for template_file in "${TEMPLATE_FILES[@]}"; do
    template_name="$(basename "$template_file")"

    copy_if_needed \
        "$template_file" \
        "$PROJECT_ROOT/$template_name"
done

echo ""
echo "Generator files are available in:"
echo "  $PROJECT_ROOT"
echo ""

echo "Running the Python script with the following arguments:"
echo "  1) $DRIVER_NAME"
echo "  2) $DTSI_FILE_ABS"
echo "  3) $FIFO_NAME"
echo ""

# Run the Python generator from the project root.
if (
    cd "$PROJECT_ROOT"

    "$PYTHON_BIN" \
        "$COPIED_SOURCE_PY" \
        "$DRIVER_NAME" \
        "$DTSI_FILE_ABS" \
        "$FIFO_NAME"
)
then
    echo ""
    echo "Python script completed successfully."
else
    RETVAL=$?

    echo "" >&2
    echo "Error: Python script exited with return code $RETVAL." >&2
    exit "$RETVAL"
fi

# The Python generator creates lowercase filenames.
DRIVER_NAME_LOWER="${DRIVER_NAME,,}"

GENERATED_SOURCE="$PROJECT_ROOT/${DRIVER_NAME_LOWER}.c"
GENERATED_HEADER="$PROJECT_ROOT/${DRIVER_NAME_LOWER}.h"

if [[ ! -f "$GENERATED_SOURCE" ]]; then
    echo "Error: generated source file was not found:" >&2
    echo "  $GENERATED_SOURCE" >&2
    exit 1
fi

if [[ ! -f "$GENERATED_HEADER" ]]; then
    echo "Error: generated header file was not found:" >&2
    echo "  $GENERATED_HEADER" >&2
    exit 1
fi

echo ""
echo "Copying generated driver files..."
echo ""

cp -f -- \
    "$GENERATED_SOURCE" \
    "$DRIVER_FILES_DIR/${DRIVER_NAME}.c"

cp -f -- \
    "$GENERATED_HEADER" \
    "$DRIVER_FILES_DIR/${DRIVER_NAME}.h"

echo "Generated driver files copied successfully:"
echo "  $DRIVER_FILES_DIR/${DRIVER_NAME}.c"
echo "  $DRIVER_FILES_DIR/${DRIVER_NAME}.h"
echo ""

# Update the Makefile.
MAKEFILE="$DRIVER_FILES_DIR/Makefile"

if [[ ! -f "$MAKEFILE" ]]; then
    echo "Error: Makefile not found:" >&2
    echo "  $MAKEFILE" >&2
    exit 1
fi

echo "Updating Makefile..."

INCLUDE_OPTION="-I$DRIVER_FILES_DIR"

if grep -Fq -- "$INCLUDE_OPTION" "$MAKEFILE"; then
    echo "Makefile already contains the required include path."
else
    if grep -Eq '^[[:space:]]*MY_CFLAGS[[:space:]]*\+=' "$MAKEFILE"; then
        sed -i \
            "/^[[:space:]]*MY_CFLAGS[[:space:]]*+=/ s|\$| $INCLUDE_OPTION|" \
            "$MAKEFILE"
    else
        echo "MY_CFLAGS += -g -DDEBUG $INCLUDE_OPTION" >> "$MAKEFILE"
    fi

    echo "Makefile updated successfully."
fi

echo ""
echo "Resulting MY_CFLAGS line:"
grep -E '^[[:space:]]*MY_CFLAGS[[:space:]]*\+=' "$MAKEFILE" || true

echo ""
echo "Building PetaLinux kernel module '$DRIVER_NAME'..."
echo ""

if "$PETALINUX_BUILD_BIN" -c "$DRIVER_NAME"; then
    echo ""
    echo "PetaLinux kernel module built successfully."
else
    RETVAL=$?

    echo "" >&2
    echo "Error: petalinux-build failed with return code $RETVAL." >&2
    exit "$RETVAL"
fi

###############################################################################
# Create driver wrapper directory
###############################################################################

echo ""
echo "Creating driver wrapper directory..."

WRAPPER_DIR="$PROJECT_ROOT/${DRIVER_NAME}_wrapper"

if [[ -e "$WRAPPER_DIR" && ! -d "$WRAPPER_DIR" ]]; then
    echo "Error: wrapper path exists but is not a directory:" >&2
    echo "  $WRAPPER_DIR" >&2
    exit 1
fi

mkdir -p "$WRAPPER_DIR"

###############################################################################
# Locate and copy the kernel module
###############################################################################

KO_SEARCH_ROOT="$PROJECT_ROOT/build/tmp/sysroots-components/xilinx_k26_kr/$DRIVER_NAME"

KO_FILE="$KO_SEARCH_ROOT/lib/modules/5.15.36-xilinx-v2022.2/extra/${DRIVER_NAME}.ko"

# Fall back to a recursive search if the exact kernel-version path changes.
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
    echo "Error: kernel module was not found:" >&2
    echo "  ${DRIVER_NAME}.ko" >&2
    echo "Search directory:" >&2
    echo "  $KO_SEARCH_ROOT" >&2
    exit 1
fi

cp -f -- "$KO_FILE" "$WRAPPER_DIR/${DRIVER_NAME}.ko"

###############################################################################
# Copy the generated source and header
###############################################################################

DRIVER_SOURCE_FILE="$DRIVER_FILES_DIR/${DRIVER_NAME}.c"
DRIVER_HEADER_FILE="$DRIVER_FILES_DIR/${DRIVER_NAME}.h"

if [[ ! -f "$DRIVER_SOURCE_FILE" ]]; then
    echo "Error: driver source file was not found:" >&2
    echo "  $DRIVER_SOURCE_FILE" >&2
    exit 1
fi

if [[ ! -f "$DRIVER_HEADER_FILE" ]]; then
    echo "Error: driver header file was not found:" >&2
    echo "  $DRIVER_HEADER_FILE" >&2
    exit 1
fi

cp -f -- "$DRIVER_SOURCE_FILE" "$WRAPPER_DIR/"
cp -f -- "$DRIVER_HEADER_FILE" "$WRAPPER_DIR/"

###############################################################################
# Copy the programmable-logic device-tree overlay
###############################################################################

DTBO_FILE="$PROJECT_ROOT/images/linux/pl.dtbo"

if [[ ! -f "$DTBO_FILE" ]]; then
    echo "Error: pl.dtbo was not found:" >&2
    echo "  $DTBO_FILE" >&2
    exit 1
fi

cp -f -- "$DTBO_FILE" "$WRAPPER_DIR/pl.dtbo"

###############################################################################
# Locate and copy the WIC image
###############################################################################

WIC_FILE=""

# First search in the directory explicitly requested.
WIC_FILE="$(
    find "$DRIVER_FILES_DIR" \
        -maxdepth 1 \
        -type f \
        -name '*.wic' \
        -print \
        -quit 2>/dev/null || true
)"

# PetaLinux normally stores generated WIC images under images/linux.
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
    echo "Error: no .wic file was found." >&2
    echo "Checked directories:" >&2
    echo "  $DRIVER_FILES_DIR" >&2
    echo "  $PROJECT_ROOT/images/linux" >&2
    exit 1
fi

cp -f -- "$WIC_FILE" "$WRAPPER_DIR/"

echo ""
echo "Driver wrapper created successfully:"
echo "  $WRAPPER_DIR"
echo ""
echo "Wrapper contents:"
ls -lh "$WRAPPER_DIR"

echo ""
echo "Driver creation, build, and packaging completed successfully."
echo ""