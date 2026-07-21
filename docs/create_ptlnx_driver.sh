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
# Create reduced PL overlay and compile it from pl.dtsi
###############################################################################

echo "Creating reduced programmable-logic device-tree overlay..."
echo ""

DTC_BIN="$(command -v dtc || true)"

if [[ -z "$DTC_BIN" ]]; then
    DTC_BIN="$PROJECT_ROOT/build/tmp/sysroots-components/x86_64/dtc-native/usr/bin/dtc"
fi

if [[ ! -x "$DTC_BIN" ]]; then
    echo "Error: device-tree compiler 'dtc' was not found." >&2
    echo "Checked PATH and:" >&2
    echo "  $PROJECT_ROOT/build/tmp/sysroots-components/x86_64/dtc-native/usr/bin/dtc" >&2
    echo "" >&2
    echo "Build the PetaLinux device-tree component first, for example:" >&2
    echo "  petalinux-build -c device-tree" >&2
    exit 1
fi

PL_OVERLAY_DTSI_FILE="$WRAPPER_DIR/pl.dtsi"
PL_DTBO_FILE="$WRAPPER_DIR/pl.dtbo"

# Generate a reduced overlay by:
#   1. removing fragment@0;
#   2. keeping fragment@1;
#   3. moving every top-level property of fragment@2's __overlay__ to the
#      beginning of fragment@1's __overlay__;
#   4. appending all child nodes of fragment@2 after the child nodes already
#      present in fragment@1;
#   5. removing fragment@2.
#
# Device Tree properties must precede child nodes. A brace-aware Python parser
# is used so the transformation is independent of indentation and nested nodes.
"$PYTHON_BIN" - "$PL_DTSI_FILE_ABS" "$PL_OVERLAY_DTSI_FILE" <<'PY_DTSI'
import re
import sys
from pathlib import Path

source_path = Path(sys.argv[1])
destination_path = Path(sys.argv[2])
text = source_path.read_text(encoding="utf-8")


def matching_brace(data: str, opening: int) -> int:
    depth = 0
    state = "normal"
    i = opening

    while i < len(data):
        ch = data[i]
        nxt = data[i + 1] if i + 1 < len(data) else ""

        if state == "normal":
            if ch == '"':
                state = "string"
            elif ch == "/" and nxt == "*":
                state = "block_comment"
                i += 1
            elif ch == "/" and nxt == "/":
                state = "line_comment"
                i += 1
            elif ch == "{":
                depth += 1
            elif ch == "}":
                depth -= 1
                if depth == 0:
                    return i

        elif state == "string":
            if ch == "\\":
                i += 1
            elif ch == '"':
                state = "normal"

        elif state == "block_comment":
            if ch == "*" and nxt == "/":
                state = "normal"
                i += 1

        elif state == "line_comment":
            if ch == "\n":
                state = "normal"

        i += 1

    raise ValueError("unbalanced braces")


def find_fragment(data: str, number: int):
    pattern = re.compile(rf"(?m)^[ \t]*fragment@{number}[ \t]*\{{")
    matches = list(pattern.finditer(data))

    if len(matches) != 1:
        raise ValueError(
            f"expected exactly one fragment@{number}, found {len(matches)}"
        )

    match = matches[0]
    opening = data.find("{", match.start(), match.end())
    closing = matching_brace(data, opening)

    end = closing + 1
    while end < len(data) and data[end] in " \t":
        end += 1
    if end < len(data) and data[end] == ";":
        end += 1
    if end < len(data) and data[end] == "\r":
        end += 1
    if end < len(data) and data[end] == "\n":
        end += 1

    return match.start(), end, data[match.start():end]


def find_overlay_body(fragment: str):
    pattern = re.compile(
        r"(?m)^[ \t]*(?:[A-Za-z_][A-Za-z0-9_]*[ \t]*:[ \t]*)?"
        r"__overlay__[ \t]*\{"
    )
    matches = list(pattern.finditer(fragment))

    if len(matches) != 1:
        raise ValueError(
            f"expected exactly one __overlay__ node, found {len(matches)}"
        )

    match = matches[0]
    opening = fragment.find("{", match.start(), match.end())
    closing = matching_brace(fragment, opening)
    return opening + 1, closing


def split_top_level_items(body: str):
    """Return top-level DTS properties and child nodes from an overlay body."""
    items = []
    start = 0
    depth = 0
    state = "normal"
    i = 0

    while i < len(body):
        ch = body[i]
        nxt = body[i + 1] if i + 1 < len(body) else ""

        if state == "normal":
            if ch == '"':
                state = "string"
            elif ch == "/" and nxt == "*":
                state = "block_comment"
                i += 1
            elif ch == "/" and nxt == "/":
                state = "line_comment"
                i += 1
            elif ch == "{":
                depth += 1
            elif ch == "}":
                depth -= 1
                if depth < 0:
                    raise ValueError("unexpected closing brace in overlay body")
            elif ch == ";" and depth == 0:
                item = body[start:i + 1].strip()
                if item:
                    items.append(item)
                start = i + 1

        elif state == "string":
            if ch == "\\":
                i += 1
            elif ch == '"':
                state = "normal"

        elif state == "block_comment":
            if ch == "*" and nxt == "/":
                state = "normal"
                i += 1

        elif state == "line_comment":
            if ch == "\n":
                state = "normal"

        i += 1

    trailing = body[start:].strip()
    if trailing:
        raise ValueError(f"unparsed trailing overlay content: {trailing[:80]!r}")

    properties = []
    children = []

    for item in items:
        if "{" in item:
            children.append(item)
        else:
            properties.append(item)

    return properties, children


def property_name(statement: str):
    match = re.match(r"\s*([#A-Za-z_][#A-Za-z0-9_,+.-]*)\s*=", statement)
    return match.group(1) if match else None


def indent_block(block: str, indentation: str) -> str:
    lines = block.splitlines()
    nonempty = [line for line in lines if line.strip()]
    if not nonempty:
        return ""

    common = min(len(line) - len(line.lstrip()) for line in nonempty)
    normalized = [line[common:] if line.strip() else "" for line in lines]
    return "\n".join(indentation + line if line else "" for line in normalized)


try:
    fragment0 = find_fragment(text, 0)
    fragment1 = find_fragment(text, 1)
    fragment2 = find_fragment(text, 2)

    body1_start, body1_end = find_overlay_body(fragment1[2])
    body2_start, body2_end = find_overlay_body(fragment2[2])

    fragment1_text = fragment1[2]
    body1 = fragment1_text[body1_start:body1_end]
    body2 = fragment2[2][body2_start:body2_end]

    properties1, children1 = split_top_level_items(body1)
    properties2, children2 = split_top_level_items(body2)

    # Merge properties while avoiding duplicate property names. Properties
    # already present in fragment@1 take precedence.
    merged_properties = []
    seen_property_names = set()

    for statement in properties1 + properties2:
        name = property_name(statement)
        if name is not None and name in seen_property_names:
            continue
        if name is not None:
            seen_property_names.add(name)
        merged_properties.append(statement)

    required = {"#address-cells", "#size-cells"}
    missing = required - seen_property_names
    if missing:
        raise ValueError(
            "missing required overlay properties: " + ", ".join(sorted(missing))
        )

    overlay_line_start = fragment1_text.rfind("\n", 0, body1_start) + 1
    overlay_line = fragment1_text[overlay_line_start:body1_start]
    overlay_indent = re.match(r"[ \t]*", overlay_line).group(0)
    item_indent = overlay_indent + "        "

    ordered_items = merged_properties + children1 + children2
    merged_body = "\n".join(
        indent_block(item, item_indent) for item in ordered_items if item.strip()
    )

    closing_line_start = fragment1_text.rfind("\n", 0, body1_end) + 1
    closing_indent = fragment1_text[closing_line_start:body1_end]

    merged_fragment1 = (
        fragment1_text[:body1_start]
        + "\n"
        + merged_body
        + "\n"
        + closing_indent
        + fragment1_text[body1_end:]
    )

    replacements = [
        (fragment0[0], fragment0[1], ""),
        (fragment1[0], fragment1[1], merged_fragment1),
        (fragment2[0], fragment2[1], ""),
    ]

    result = text
    for begin, finish, replacement in sorted(
        replacements, key=lambda item: item[0], reverse=True
    ):
        result = result[:begin] + replacement + result[finish:]

    if "fragment@0" in result or "fragment@2" in result:
        raise ValueError("fragment@0 or fragment@2 remained in generated file")
    if result.count("fragment@1") != 1:
        raise ValueError("generated file does not contain exactly one fragment@1")

    # Validate property ordering in the generated overlay before invoking dtc.
    generated_fragment1 = find_fragment(result, 1)[2]
    generated_body_start, generated_body_end = find_overlay_body(generated_fragment1)
    generated_body = generated_fragment1[generated_body_start:generated_body_end]
    generated_properties, generated_children = split_top_level_items(generated_body)

    if not generated_children:
        raise ValueError("generated overlay contains no child nodes")

    generated_property_names = {
        name for name in map(property_name, generated_properties) if name is not None
    }
    if not required.issubset(generated_property_names):
        raise ValueError("generated overlay lost address/size cell properties")

    destination_path.write_text(result, encoding="utf-8")

except (OSError, ValueError) as exc:
    print(f"Error while generating reduced pl.dtsi: {exc}", file=sys.stderr)
    sys.exit(1)
PY_DTSI

if [[ ! -s "$PL_OVERLAY_DTSI_FILE" ]]; then
    echo "Error: generated reduced pl.dtsi is missing or empty:" >&2
    echo "  $PL_OVERLAY_DTSI_FILE" >&2
    exit 1
fi

if grep -Eq 'fragment@0|fragment@2' "$PL_OVERLAY_DTSI_FILE"; then
    echo "Error: generated pl.dtsi still contains fragment@0 or fragment@2." >&2
    rm -f "$PL_OVERLAY_DTSI_FILE"
    exit 1
fi

if ! grep -Eq 'fragment@1[[:space:]]*\{' "$PL_OVERLAY_DTSI_FILE"; then
    echo "Error: generated pl.dtsi does not contain fragment@1." >&2
    rm -f "$PL_OVERLAY_DTSI_FILE"
    exit 1
fi

echo "Reduced overlay source generated:"
echo "  $PL_OVERLAY_DTSI_FILE"
echo ""
echo "DTC compiler:"
echo "  $DTC_BIN"
echo ""
echo "Overlay output:"
echo "  $PL_DTBO_FILE"
echo ""

if "$DTC_BIN" \
    -@ \
    -I dts \
    -O dtb \
    -o "$PL_DTBO_FILE" \
    "$PL_OVERLAY_DTSI_FILE"; then
    echo "Device-tree overlay compiled successfully."
else
    RETVAL=$?
    echo "Error: failed to compile the reduced pl.dtsi into pl.dtbo." >&2
    echo "Return code: $RETVAL" >&2
    rm -f "$PL_DTBO_FILE"
    exit "$RETVAL"
fi

if [[ ! -s "$PL_DTBO_FILE" ]]; then
    echo "Error: generated pl.dtbo is missing or empty:" >&2
    echo "  $PL_DTBO_FILE" >&2
    exit 1
fi

echo "Generated DTBO:"
echo "  $PL_DTBO_FILE"
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
echo "    pl.dtsi"
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