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

# Resolve absolute paths.
SOURCE_PY_ABS="$(realpath "$SOURCE_PY")"
DTSI_FILE_ABS="$(realpath "$DTSI_FILE")"
SOURCE_DIR="$(dirname "$SOURCE_PY_ABS")"
DEST_DIR="$(pwd)"

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

echo ""
echo "Driver name      : $DRIVER_NAME"
echo "Python file      : $SOURCE_PY_ABS"
echo "DTSI file        : $DTSI_FILE_ABS"
echo "FIFO name        : $FIFO_NAME"
echo "Destination      : $DEST_DIR"
echo "Template file #1 : ${TEMPLATE_FILES[0]}"
echo "Template file #2 : ${TEMPLATE_FILES[1]}"
echo ""

# Copy the Python file and the two template files
# to the directory from which this script was launched.
cp -- "$SOURCE_PY_ABS" "$DEST_DIR/"
cp -- "${TEMPLATE_FILES[0]}" "$DEST_DIR/"
cp -- "${TEMPLATE_FILES[1]}" "$DEST_DIR/"

echo "Files copied successfully."
echo ""

# Locate an available Python interpreter.
PYTHON_BIN="$(command -v python3 || command -v python || true)"

if [[ -z "$PYTHON_BIN" ]]; then
    echo "Error: no Python interpreter was found." >&2
    echo "Install python3 or make python available in PATH." >&2
    exit 1
fi

echo "Python interpreter: $PYTHON_BIN"
echo ""
echo "Running the Python script with the following arguments:"
echo "  1) $DRIVER_NAME"
echo "  2) $DTSI_FILE_ABS"
echo "  3) $FIFO_NAME"
echo ""

# Run the Python script using the required argument order:
#   1. driver name
#   2. absolute DTSI path
#   3. FIFO name
if "$PYTHON_BIN" \
    "$SOURCE_PY_ABS" \
    "$DRIVER_NAME" \
    "$DTSI_FILE_ABS" \
    "$FIFO_NAME"
then
    echo ""
    echo "Python script completed successfully."
else
    RETVAL=$?

    echo "" >&2
    echo "Error: Python script exited with return code $RETVAL." >&2
    exit "$RETVAL"
fi

echo ""