#!/usr/bin/env bash
# Create a PetaLinux 2025.1 project, generate its driver and package the SD image.
# Settings are chosen in PetaLinux menus, except the requested startup/systemd selection.
set -Eeuo pipefail

PROJECT_NAME=""
SDT_DIR=""
BSP_FILE=""
DRIVER_NAME=""
GENERATOR_DIR="/opt/petalinux/docs/driver_generation"
SETTINGS_FILE="/opt/petalinux/2025.1/settings.sh"
SCRIPT_DIR=$(dirname -- "$(realpath -- "${BASH_SOURCE[0]}")")
PROJECT_ROOT=""
WORK_DIR=""
RESUME=false
NO_STARTUP=false
SETTINGS_OPTION_SET=false
GENERATOR_OPTION_SET=false
LAST_STEP=0
CURRENT_STEP=0
STATE_DIR=""

# Use colors only on terminals. NO_COLOR also disables them explicitly.
MSG_BLUE=""
MSG_CYAN=""
MSG_GREEN=""
MSG_RESET=""
MSG_ERROR_RED=""
MSG_ERROR_RESET=""
if [[ -t 1 && "${TERM:-dumb}" != dumb && -z "${NO_COLOR+x}" ]]; then
    MSG_BLUE=$'\033[1;34m'
    MSG_CYAN=$'\033[36m'
    MSG_GREEN=$'\033[1;32m'
    MSG_RESET=$'\033[0m'
fi
if [[ -t 2 && "${TERM:-dumb}" != dumb && -z "${NO_COLOR+x}" ]]; then
    MSG_ERROR_RED=$'\033[1;31m'
    MSG_ERROR_RESET=$'\033[0m'
fi

info() {
    printf '%s[INFO]%s %s\n' "$MSG_CYAN" "$MSG_RESET" "$*"
}

success() {
    printf '%s[OK]%s %s\n' "$MSG_GREEN" "$MSG_RESET" "$*"
}

section() {
    printf '\n%s================================================================\n' "$MSG_BLUE"
    printf '[STEP] %s\n' "$*"
    printf '================================================================%s\n\n' "$MSG_RESET"
}

print_error() {
    printf '\n%s----------------------------------------------------------------\n' "$MSG_ERROR_RED" >&2
    printf '[ERROR] %s\n' "$*" >&2
    printf '%s\n' "----------------------------------------------------------------${MSG_ERROR_RESET}" >&2
}

error() {
    print_error "$*"
    exit 1
}

on_error() {
    local status=$1
    local line=$2
    print_error "Command failed at line $line (exit code $status)."
    return "$status"
}

usage() {
    cat <<'HELP'
Usage:
  ./unified_ptlx_prj.sh -n NAME -sdt DIR [-bsp FILE] [options]

Options:
  -n NAME             Name of the new PetaLinux project directory
  -sdt DIR            SDT hardware directory exported with Vivado/Vitis 2025.1
  -bsp FILE           PetaLinux 2025.1 BSP matching the board and SDT flow
  -gen DIR            Driver generator directory
                      Default: /opt/petalinux/docs/driver_generation
  --driver-name NAME  C module name; otherwise derived from the project name
  --settings FILE     PetaLinux settings.sh
                      Default: /opt/petalinux/2025.1/settings.sh
  --no-startup        Skip startupbash creation and automatic systemd selection
  --resume            Continue an existing project from its last completed step
                      Saved paths/options are reused when omitted
  -h, --help          Show this help

Without --resume, the project must be new. Run in a terminal without sudo.
Resume example, from the directory containing the project:
  ./unified_ptlx_prj.sh -n my-project --resume
Progress and input paths are stored in <project>/.unified-state/.
A failed step is repeated; completed steps are skipped. PetaLinux reuses its cache.
For older projects without state, resume is supported after a completed base build
and driver generation. Existing wrapper PL files can supply the original inputs.
Without -bsp, use the only BSP beside this script, or ask for its path.
The SDT directory must contain exactly one .bit and one PL .bin file.
The generator directory must contain one .py, one .c.template and one .h.template.

Steps:
  1. Create the project from the BSP.
  2. Import SDT hardware and open the project configuration menu.
  3. Open the kernel configuration menu.
  4. Generate the driver sources and create its module recipe.
  5. Open the root filesystem menu; select the driver there if required.
  6. Build the system and the driver.
  7. Compile components/plnx_workspace/device-tree/pl-overlay-full/pl.dtsi.
  8. Unless --no-startup: create startupbash, enable it with systemd, and rebuild.
  9. Package BOOT.BIN and petalinux-sdimage.wic.

Select rootfs.tar.gz output in the project menu for WIC packaging.
Choose console, rootfs, FPGA Manager, overlays, PTP and packages in the menus.
Console aliases are checked after hardware import, including on --resume.
For the known UART1/ttyPS1 mismatch, confirmation is requested [y/N].
Only confirmation adds a dedicated alias override to system-user.dtsi.
Declining leaves the device tree unchanged and continues the workflow.
No saved -cfg import, diagnostic package, firmware-domain override or QSPI
update is performed. Console aliases change only after explicit confirmation.
Without --no-startup, startupbash=y and systemd are selected automatically.
With --no-startup, the chosen init manager is preserved and no startup app is created.
The manual program_fpga.sh is exported in both modes. The choice is saved for
--resume; changing an existing project startup mode requires a new project.
These two choices are applied after the rootfs menu and normalized by one rootfs
--silentconfig call. Other menu selections are preserved.
Startup initializes the FPGA, overlay and driver. The application packages its own .ko.
The overlay source is exclusively:
  components/plnx_workspace/device-tree/pl-overlay-full/pl.dtsi
It must exist after the base build; no alternate source is selected automatically.
The overlay source is not patched. A confirmed console repair adds an include
to system-user.dtsi and causes completed builds and packaging to run again.
An overlay with firmware-name requests its packaged bitstream; otherwise startup
programs the bitstream explicitly. No bitstream is added to BOOT.BIN.
Packaging BOOT.BIN on SD does not update the K26 QSPI firmware.

Output:
  <project>/images/linux/BOOT.BIN
  <project>/images/linux/petalinux-sdimage.wic
  <project>/<project>_wrapper/petalinux-sdimage.wic
  <project>/<project>_wrapper/code/       Driver .c and .h
  <project>/<project>_wrapper/fpga/       Module, original PL files and overlay
                                       BOOT.BIN, zynqmp_fsbl.elf and program_fpga.sh
HELP
}

# Check the imported SDT together with the generated and user console settings.
# Only the diagnosed ZynqMP UART1/ttyPS1 mismatch is offered for repair.
check_console_aliases() {
    local hw="$PROJECT_ROOT/project-spec/hw-description"
    local dt_dir="$PROJECT_ROOT/components/plnx_workspace/device-tree"
    local user_dir="$PROJECT_ROOT/project-spec/meta-user/recipes-bsp/device-tree/files"
    local user_dts="$user_dir/system-user.dtsi"
    local fix="$user_dir/unified-console-aliases.dtsi"
    local recipe="$PROJECT_ROOT/project-spec/meta-user/recipes-bsp/device-tree/device-tree.bbappend"
    local fetch='SRC_URI:append = " file://unified-console-aliases.dtsi"'
    local include='/include/ "unified-console-aliases.dtsi"'
    local source="$WORK_DIR/console-check.dts" tree="$WORK_DIR/console-check.dtb"
    local fdtget="$(dirname -- "$DTC")/fdtget"
    local uart0 uart1 alias0 alias1 stdout bootargs status answer

    section 'Checking serial console aliases.'
    if [[ ! -x "$DTC" || ! -x "$fdtget" ]] || ! command -v cpp >/dev/null; then
        info 'Console check unavailable: cpp, dtc and fdtget are required. Continuing unchanged.'
        return 0
    fi
    if [[ ! -r "$hw/system-top.dts" || ! -r "$user_dts" || ! -r "$dt_dir/system-conf.dtsi" ]]; then
        info 'Console sources are unavailable. Continuing without changing aliases.'
        return 0
    fi
    if ! cpp -nostdinc -undef -D__DTS__ -x assembler-with-cpp -I "$hw" \
        "$hw/system-top.dts" -o "$source" 2> "$WORK_DIR/console-check.log"; then
        info 'Could not preprocess the SDT. Continuing without changing aliases.'
        return 0
    fi
    printf '\n/include/ "%s"\n' "$user_dts" >> "$source"
    if ! "$DTC" -@ -I dts -O dtb -i "$dt_dir" -i "$user_dir" \
        -o "$tree" "$source" 2>> "$WORK_DIR/console-check.log"; then
        info 'Could not resolve the console sources. Continuing without changing aliases.'
        return 0
    fi
    uart0=$("$fdtget" -t s "$tree" /__symbols__ uart0 2>/dev/null) || return 0
    uart1=$("$fdtget" -t s "$tree" /__symbols__ uart1 2>/dev/null) || return 0
    alias0=$("$fdtget" -t s "$tree" /aliases serial0 2>/dev/null) || alias0=''
    alias1=$("$fdtget" -t s "$tree" /aliases serial1 2>/dev/null) || alias1=''
    stdout=$("$fdtget" -t s "$tree" /chosen stdout-path 2>/dev/null) || stdout=''
    bootargs=$("$fdtget" -t s "$tree" /chosen bootargs 2>/dev/null) || bootargs=''
    status=$("$fdtget" -t s "$tree" "$uart1" status 2>/dev/null) || status='okay'
    info "serial0 -> $alias0; serial1 -> $alias1"
    info "stdout-path: $stdout"
    info "Kernel arguments: $bootargs"

    if [[ "$alias1" == "$uart1" && "$stdout" == serial1:* && " $bootargs " == *' console=ttyPS1,'* ]]; then
        success 'UART1 aliases and ttyPS1 console are aligned.'
        return 0
    fi
    if [[ "$uart0" != */serial@ff000000 || "$uart1" != */serial@ff010000 || \
          "$status" != okay || "$alias0" != "$uart1" || "$alias1" != */coresight@fe800000 || \
          "$stdout" != serial1:* || " $bootargs " != *' console=ttyPS1,'* ]]; then
        info 'The known UART1/ttyPS1 alias mismatch was not detected. Continuing unchanged.'
        return 0
    fi
    info 'Mismatch: ttyPS1/stdout-path select serial1, which points to CoreSight instead of UART1.'
    info 'Proposed change: serial0 -> UART0, serial1 -> UART1. Boot arguments are preserved.'
    answer=''
    if ! read -r -p 'Realign the console aliases? [y/N]: ' answer; then
        answer=''
    fi
    case "$answer" in
        y|Y|yes|Yes|YES) ;;
        *) info 'Aliases left unchanged by user choice. Continuing.'; return 0 ;;
    esac
    if [[ -L "$user_dts" || -L "$recipe" || ! -f "$recipe" || -e "$fix" || -L "$fix" ]]; then
        error 'Cannot safely add the console override: a symlink or an existing override was found.'
    fi
    # Validate the proposed aliases before modifying any project source.
    cat > "$WORK_DIR/unified-console-aliases.dtsi" <<CONSOLE_DTS
/* Added by unified_ptlx_prj.sh after explicit user confirmation. */
/ {
    aliases {
        serial0 = "$uart0";
        serial1 = "$uart1";
    };
};
CONSOLE_DTS
    printf '\n/include/ "%s"\n' "$WORK_DIR/unified-console-aliases.dtsi" >> "$source"
    if ! "$DTC" -@ -I dts -O dtb -i "$dt_dir" -i "$user_dir" \
        -o "$tree" "$source" 2>> "$WORK_DIR/console-check.log"; then
        error 'The proposed console override did not compile; project sources are unchanged.'
    fi
    [[ "$("$fdtget" -t s "$tree" /aliases serial1)" == "$uart1" ]] || \
        error 'The proposed alias did not resolve to UART1; project sources are unchanged.'
    # Invalidate completed builds before writing, so an interrupted run can resume safely.
    if (( LAST_STEP >= 6 )); then
        checkpoint 5
        info 'Console change requires rebuilding and repackaging the image.'
    fi
    # Include the fragment in recipe inputs, so it reaches the build workspace.
    if ! grep -Fqx "$fetch" "$recipe"; then
        printf '\n%s\n' "$fetch" >> "$recipe"
    fi
    cp -- "$user_dts" "$WORK_DIR/system-user.console.dtsi"
    printf '\n%s\n' "$include" >> "$WORK_DIR/system-user.console.dtsi"
    cp -- "$WORK_DIR/unified-console-aliases.dtsi" "$fix"
    if ! cat "$WORK_DIR/system-user.console.dtsi" > "$user_dts"; then
        error 'Could not update system-user.dtsi; review it before resuming.'
    fi
    success 'Console aliases aligned after confirmation; UART0 enablement and boot arguments are unchanged.'
}

# Save progress only after the complete step succeeds.
checkpoint() {
    printf '%s\n' "$1" > "$STATE_DIR/last-step.tmp"
    mv -- "$STATE_DIR/last-step.tmp" "$STATE_DIR/last-step"
    LAST_STEP=$1
    info "Saved progress: step $LAST_STEP/13 completed."
}

cleanup() {
    if [[ -n "$WORK_DIR" && "$WORK_DIR" == "$PROJECT_ROOT"/.unified-work.* ]]; then
        rm -rf -- "$WORK_DIR"
    fi
}

trap 'on_error "$?" "$LINENO"' ERR
trap cleanup EXIT

# Read options before creating or changing any project files.
while (( $# > 0 )); do
    case "$1" in
        -h|--h|--help)
            usage
            exit 0
            ;;
        --no-startup)
            NO_STARTUP=true
            shift
            ;;
        --resume)
            RESUME=true
            shift
            ;;
        -cfg|--console|--force-driver)
            error "$1 is no longer supported. Use a new project and configure it through the menus."
            ;;
        -n|-sdt|-bsp|-gen|--driver-name|--settings)
            if (( $# < 2 )) || [[ -z "$2" || "$2" == -* ]]; then
                error "Missing value after $1."
            fi
            case "$1" in
                -n) PROJECT_NAME=$2 ;;
                -sdt) SDT_DIR=$2 ;;
                -bsp) BSP_FILE=$2 ;;
                -gen) GENERATOR_DIR=$2; GENERATOR_OPTION_SET=true ;;
                --driver-name) DRIVER_NAME=$2 ;;
                --settings) SETTINGS_FILE=$2; SETTINGS_OPTION_SET=true ;;
            esac
            shift 2
            ;;
        *)
            error "Unknown option: $1. Use --help."
            ;;
    esac
done

if [[ -z "$PROJECT_NAME" ]]; then
    usage
    error '-n is required.'
fi
if [[ ! "$PROJECT_NAME" =~ ^[A-Za-z0-9][A-Za-z0-9_.-]*$ ]]; then
    error 'Use a directory name, not a path, for -n.'
fi
if [[ "$RESUME" == true ]]; then
    if [[ ! -d "$PROJECT_NAME" || -L "$PROJECT_NAME" ]]; then
        error "Cannot resume a missing or symlinked project: $PROJECT_NAME"
    fi
    PROJECT_ROOT=$(realpath -- "$PROJECT_NAME")
    STATE_DIR="$PROJECT_ROOT/.unified-state"
    if [[ -L "$STATE_DIR" ]]; then error 'The resume state directory must not be a symlink.'; fi
    if [[ ! -s "$PROJECT_ROOT/project-spec/configs/config" ]]; then
        error 'The selected directory is not a configured PetaLinux project.'
    fi
    if [[ -f "$STATE_DIR/last-step" ]]; then
        LAST_STEP=$(cat "$STATE_DIR/last-step")
        if [[ ! "$LAST_STEP" =~ ^([0-9]|1[0-3])$ ]]; then error 'Invalid resume step.'; fi
        # Read plain text only; never execute the saved state as shell code.
        if [[ -f "$STATE_DIR/no-startup" ]]; then
            saved_no_startup=$(cat "$STATE_DIR/no-startup")
            case "$saved_no_startup" in true|false) ;; *) error 'Invalid saved startup mode.' ;; esac
            if [[ "$NO_STARTUP" == true && "$saved_no_startup" == false ]]; then
                error 'Resume startup mode changed. Use a new project for --no-startup.'
            fi
            NO_STARTUP=$saved_no_startup
        fi
        if [[ -z "$SDT_DIR" && -f "$STATE_DIR/sdt-dir" ]]; then SDT_DIR=$(cat "$STATE_DIR/sdt-dir"); fi
        if [[ -z "$DRIVER_NAME" && -f "$STATE_DIR/driver-name" ]]; then DRIVER_NAME=$(cat "$STATE_DIR/driver-name"); fi
        if [[ "$SETTINGS_OPTION_SET" == false && -f "$STATE_DIR/settings-file" ]]; then SETTINGS_FILE=$(cat "$STATE_DIR/settings-file"); fi
        if [[ "$GENERATOR_OPTION_SET" == false && -f "$STATE_DIR/generator-dir" ]]; then GENERATOR_DIR=$(cat "$STATE_DIR/generator-dir"); fi
    fi
    if [[ -z "$SDT_DIR" ]]; then
        SDT_DIR="$PROJECT_ROOT/${PROJECT_NAME}_wrapper/fpga"
    fi
else
    if [[ -z "$SDT_DIR" ]]; then error '-sdt is required for a new project.'; fi
    if [[ -e "$PROJECT_NAME" || -L "$PROJECT_NAME" ]]; then
        error "Project already exists: $PROJECT_NAME. Use --resume to continue it."
    fi
fi
if [[ ! -t 0 || ! -t 1 ]]; then
    error 'Run in an interactive terminal so the PetaLinux menus can open.'
fi
if (( EUID == 0 )); then
    error 'Run PetaLinux as a normal user, without sudo.'
fi

# Resolve paths before entering the new project directory.
if [[ ! -d "$SDT_DIR" || ! -d "$GENERATOR_DIR" ]]; then
    error 'The SDT directory or driver generator directory does not exist.'
fi
SDT_DIR=$(realpath -- "$SDT_DIR")
GENERATOR_DIR=$(realpath -- "$GENERATOR_DIR")
case "$(realpath -m -- "$PROJECT_NAME")/" in
    "$SDT_DIR/"*) error 'Create the project outside the SDT input directory.' ;;
esac
if [[ ! -r "$SETTINGS_FILE" ]]; then
    error "PetaLinux settings file not found: $SETTINGS_FILE"
fi
SETTINGS_FILE=$(realpath -- "$SETTINGS_FILE")

if [[ "$RESUME" == false ]]; then
if [[ -z "$BSP_FILE" ]]; then
    mapfile -d '' -t bsp_files < <(find "$SCRIPT_DIR" -maxdepth 1 -iname '*.bsp' -type f -print0)
    if (( ${#bsp_files[@]} == 1 )); then
        BSP_FILE=${bsp_files[0]}
    else
        info 'Enter the path to the PetaLinux 2025.1 BSP for this board.'
        read -r -p 'BSP file: ' BSP_FILE
    fi
fi
if [[ "$BSP_FILE" == '~/'* ]]; then
    BSP_FILE="$HOME/${BSP_FILE:2}"
fi
if [[ ! -f "$BSP_FILE" || ! -r "$BSP_FILE" || ! -s "$BSP_FILE" ]]; then
    error "BSP file missing, unreadable or empty: $BSP_FILE"
fi
BSP_FILE=$(realpath -- "$BSP_FILE")

fi

# Select the inputs without changing their contents.
mapfile -d '' -t bit_files < <(find "$SDT_DIR" -type f -iname '*.bit' -print0)
mapfile -d '' -t bin_files < <(find "$SDT_DIR" -type f -iname '*.bin' ! -iname 'BOOT.BIN' -print0)
if (( ${#bit_files[@]} != 1 || ${#bin_files[@]} != 1 )); then
    error 'The SDT directory must contain exactly one .bit and one PL .bin file.'
fi
BITSTREAM=${bit_files[0]}
PL_BINARY=${bin_files[0]}
for file in "$BITSTREAM" "$PL_BINARY"; do
    name=${file##*/}
    if [[ ! -r "$file" || ! -s "$file" || ! "$name" =~ ^[A-Za-z0-9][A-Za-z0-9_.-]*$ ]]; then
        error "Use readable, nonempty PL files with simple filenames: $file"
    fi
done

shopt -s nullglob
python_files=("$GENERATOR_DIR"/*.py)
c_templates=("$GENERATOR_DIR"/*.c.template)
h_templates=("$GENERATOR_DIR"/*.h.template)
shopt -u nullglob
if (( ${#python_files[@]} != 1 || ${#c_templates[@]} != 1 || ${#h_templates[@]} != 1 )); then
    error 'The generator directory must contain one .py, one .c.template and one .h.template.'
fi
for file in "${python_files[0]}" "${c_templates[0]}" "${h_templates[0]}"; do
    if [[ ! -r "$file" || ! -s "$file" ]]; then
        error "Generator input missing, unreadable or empty: $file"
    fi
done

if [[ -z "$DRIVER_NAME" ]]; then
    base_name=$(printf '%s' "$PROJECT_NAME" | tr -cd 'A-Za-z0-9')
    DRIVER_NAME="${base_name}Driver"
fi
if [[ ! "$DRIVER_NAME" =~ ^[A-Za-z][A-Za-z0-9_]*$ ]]; then
    error 'Driver name must start with a letter and contain only letters, digits or underscores.'
fi
MODULE_NAME=${DRIVER_NAME,,}
RECIPE_NAME=${MODULE_NAME//_/-}

# The vendor environment may use unset variables during initialization.
section 'Loading PetaLinux 2025.1.'
trap - ERR
set +e +u
set +o pipefail
# PetaLinux itself assigns SETTINGS_FILE; retain our absolute input path.
UNIFIED_SETTINGS_FILE_PATH=$SETTINGS_FILE
source "$UNIFIED_SETTINGS_FILE_PATH"
settings_status=$?
SETTINGS_FILE=$UNIFIED_SETTINGS_FILE_PATH
set -euo pipefail
trap 'on_error "$?" "$LINENO"' ERR
if (( settings_status != 0 )); then
    error 'Could not load the PetaLinux environment.'
fi
for tool in petalinux-create petalinux-config petalinux-build petalinux-package python3; do
    if ! command -v "$tool" >/dev/null; then
        error "Required command not found: $tool"
    fi
done

# Create a new project, or keep the existing one when resuming.
if [[ "$RESUME" == false ]]; then
    CURRENT_STEP=1
    section "Creating project: $PROJECT_NAME"
    petalinux-create project --source "$BSP_FILE" --name "$PROJECT_NAME"
    PROJECT_ROOT=$(realpath -- "$PROJECT_NAME")
fi
cd -- "$PROJECT_ROOT"
STATE_DIR="$PROJECT_ROOT/.unified-state"
mkdir -p "$STATE_DIR"
WORK_DIR=$(mktemp -d "$PROJECT_ROOT/.unified-work.XXXXXXXX")
MODULE_DIR="$PROJECT_ROOT/project-spec/meta-user/recipes-modules/$RECIPE_NAME"
WRAPPER="$PROJECT_ROOT/${PROJECT_NAME}_wrapper"
IMAGES="$PROJECT_ROOT/images/linux"
OVERLAY_DTS="$PROJECT_ROOT/components/plnx_workspace/device-tree/pl-overlay-full/pl.dtsi"
if command -v dtc >/dev/null; then
    DTC=$(command -v dtc)
else
    DTC="${PETALINUX:-/opt/petalinux/2025.1}/sysroots/x86_64-petalinux-linux/usr/bin/dtc"
fi

# Adopt the old workflow only when its completed build can be established.
if [[ "$RESUME" == true && ! -f "$STATE_DIR/last-step" ]]; then
    for file in "$IMAGES/Image" "$IMAGES/rootfs.tar.gz" \
        "$MODULE_DIR/$RECIPE_NAME.bb" "$MODULE_DIR/files/$MODULE_NAME.c" "$MODULE_DIR/files/$MODULE_NAME.h"; do
        if [[ ! -s "$file" ]]; then
            error "No saved resume state and required previous build output is missing: $file"
        fi
    done
    LAST_STEP=6
    if [[ -s "$IMAGES/$MODULE_NAME.ko" ]]; then LAST_STEP=7; fi
    info "Previous project recognized: continuing after step $LAST_STEP/13."
    checkpoint "$LAST_STEP"
fi

# Refuse changed options instead of applying old checkpoints to new inputs.
if [[ "$NO_STARTUP" == true && -d "$PROJECT_ROOT/project-spec/meta-user/recipes-apps/startupbash" ]]; then
    error '--no-startup does not remove an existing startupbash application. Use a new project.'
fi
for entry in sdt-dir driver-name settings-file generator-dir no-startup; do
    case "$entry" in
        sdt-dir) state_value=$SDT_DIR ;;
        driver-name) state_value=$DRIVER_NAME ;;
        settings-file) state_value=$SETTINGS_FILE ;;
        generator-dir) state_value=$GENERATOR_DIR ;;
        no-startup) state_value=$NO_STARTUP ;;
    esac
    if [[ -f "$STATE_DIR/$entry" && "$(cat "$STATE_DIR/$entry")" != "$state_value" ]]; then
        error "Resume input changed: $entry. Use the original options or a new project."
    fi
    printf '%s\n' "$state_value" > "$STATE_DIR/$entry.tmp"
    mv -- "$STATE_DIR/$entry.tmp" "$STATE_DIR/$entry"
done
if [[ "$RESUME" == false ]]; then checkpoint 1; fi
info "Continuing from completed step $LAST_STEP/13."

if (( LAST_STEP < 2 )); then
    CURRENT_STEP=2
section 'Importing SDT hardware and opening the project menu.'
info 'Select rootfs.tar.gz output and the desired root filesystem type.'
petalinux-config --get-hw-description "$SDT_DIR"
success 'Hardware import and project configuration completed.'

    checkpoint 2
fi

check_console_aliases

if (( LAST_STEP < 3 )); then
    CURRENT_STEP=3
section 'Opening the kernel configuration menu.'
info 'Select the drivers, FPGA/overlay support and PTP options required by your hardware.'
petalinux-config -c kernel
success 'Kernel configuration completed.'

    checkpoint 3
fi

# Generate only the driver sources; do not modify pl.dtsi or system-user.dtsi.
PL_DTS="$PROJECT_ROOT/project-spec/configs/pl.dtsi"
if [[ ! -r "$PL_DTS" || ! -s "$PL_DTS" ]]; then
    error 'No project-spec/configs/pl.dtsi was generated. Review the project menu and SDT input.'
fi
if (( LAST_STEP < 4 )); then
    CURRENT_STEP=4
section 'Selecting the synchronous FIFO'
# Extract only FIFO labels, without changing the device-tree source.
mapfile -t FIFO_LABELS < <(sed -nE 's/^[[:space:]]*([A-Za-z_][A-Za-z0-9_]*):[[:space:]]*axi_fifo_mm_s@[[:xdigit:]]+[[:space:]]*\{.*/\1/p' "$PL_DTS" | sort -u)
FIFO_LABEL=""
if (( ${#FIFO_LABELS[@]} == 1 )); then
    FIFO_LABEL=${FIFO_LABELS[0]}
    success "Single FIFO found; selected automatically: $FIFO_LABEL"
else
    if (( ${#FIFO_LABELS[@]} > 1 )); then
        info 'Multiple FIFOs found. Select one of these labels:'
        printf '  %s\n' "${FIFO_LABELS[@]}"
    else
        info 'No FIFO detected automatically. Enter a label manually, or press Enter for none.'
    fi
    while true; do
        read -r -p 'Synchronous FIFO label (Enter for none): ' FIFO_LABEL
        if [[ -z "$FIFO_LABEL" ]]; then
            info 'No synchronous FIFO selected.'
            break
        fi
        if [[ ! "$FIFO_LABEL" =~ ^[A-Za-z_][A-Za-z0-9_]*$ ]]; then
            print_error 'Enter a FIFO label without & or an address.'
            continue
        fi
        if (( ${#FIFO_LABELS[@]} > 1 )); then
            FIFO_FOUND=false
            for label in "${FIFO_LABELS[@]}"; do
                if [[ "$FIFO_LABEL" == "$label" ]]; then
                    FIFO_FOUND=true
                    break
                fi
            done
            if [[ "$FIFO_FOUND" == false ]]; then
                print_error 'Select one of the FIFO labels listed above.'
                continue
            fi
        fi
        success "Selected FIFO: $FIFO_LABEL"
        break
    done
fi
mkdir -p "$WORK_DIR/generator" "$WORK_DIR/sources"
cp -- "${python_files[0]}" "$WORK_DIR/generator/generate.py"
cp -- "${c_templates[0]}" "$WORK_DIR/generator/zynq_device.c.template"
cp -- "${h_templates[0]}" "$WORK_DIR/generator/zynq_device.h.template"
section "Generating driver: $MODULE_NAME"
if [[ -n "$FIFO_LABEL" ]]; then
    (cd "$WORK_DIR/sources" && python3 "$WORK_DIR/generator/generate.py" "$DRIVER_NAME" "$PL_DTS" "$FIFO_LABEL")
else
    (cd "$WORK_DIR/sources" && python3 "$WORK_DIR/generator/generate.py" "$DRIVER_NAME" "$PL_DTS")
fi
for file in "$WORK_DIR/sources/$MODULE_NAME.c" "$WORK_DIR/sources/$MODULE_NAME.h"; do
    if [[ ! -r "$file" || ! -s "$file" ]]; then
        error "The generator did not produce: $file"
    fi
    if grep -nE '\$\$[A-Za-z_][A-Za-z0-9_]*\$\$' "$file"; then
        error "Unresolved generator placeholders in: $file"
    fi
done

# The recipe and Makefile are driver build inputs, not project configuration fixes.
section "Creating module recipe: $RECIPE_NAME"
if [[ ! -d "$MODULE_DIR" ]]; then
    petalinux-create modules --name "$RECIPE_NAME"
fi
MODULE_DIR="$PROJECT_ROOT/project-spec/meta-user/recipes-modules/$RECIPE_NAME"
mkdir -p "$MODULE_DIR/files"
cp -- "$WORK_DIR/sources/$MODULE_NAME.c" "$WORK_DIR/sources/$MODULE_NAME.h" "$MODULE_DIR/files/"
printf 'obj-m := %s.o\n' "$MODULE_NAME" > "$MODULE_DIR/files/Makefile"
cat >> "$MODULE_DIR/files/Makefile" <<'MAKEFILE'

all:
	$(MAKE) -C $(KERNEL_SRC) M=$(CURDIR) modules

modules_install:
	$(MAKE) -C $(KERNEL_SRC) M=$(CURDIR) modules_install

clean:
	$(MAKE) -C $(KERNEL_SRC) M=$(CURDIR) clean
MAKEFILE
cat > "$MODULE_DIR/$RECIPE_NAME.bb" <<'RECIPE'
SUMMARY = "Generated AXI kernel module"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"
SRC_URI = "file://Makefile file://@MODULE@.c file://@MODULE@.h"
S = "${WORKDIR}"
B = "${S}"
inherit module deploy

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 ${B}/@MODULE@.ko ${DEPLOYDIR}/@MODULE@.ko
}
addtask deploy after do_compile before do_build
RECIPE
sed -i "s/@MODULE@/$MODULE_NAME/g" "$MODULE_DIR/$RECIPE_NAME.bb"

    checkpoint 4
fi

if (( LAST_STEP < 5 )); then
    CURRENT_STEP=5
section 'Opening the root filesystem configuration menu.'
info "Select $RECIPE_NAME under user packages if you want it installed in the image."
info 'Choose linuxptp, ethtool and other applications here if required.'
petalinux-config -c rootfs
success 'Root filesystem configuration completed.'

    checkpoint 5
fi

if (( LAST_STEP < 6 )); then
    CURRENT_STEP=6
section 'Building the complete PetaLinux system.'
petalinux-build
success 'System build completed.'
    checkpoint 6
fi

if (( LAST_STEP < 7 )); then
    CURRENT_STEP=7
section "Building and deploying driver: $RECIPE_NAME"
petalinux-build -c "$RECIPE_NAME"
petalinux-build -c "$RECIPE_NAME" -x do_deploy
success 'Driver build and deployment completed.'

    checkpoint 7
fi

# Locate the deployed module, including projects using an external TMPDIR.
search_roots=("$PROJECT_ROOT/build")
configured_tmp=$(sed -n 's/^CONFIG_TMP_DIR_LOCATION="\([^"]*\)"$/\1/p' "$PROJECT_ROOT/project-spec/configs/config")
configured_tmp=${configured_tmp//\$\{PROOT\}/$PROJECT_ROOT}
if [[ -n "$configured_tmp" && "$configured_tmp" != *'$'* ]]; then
    if [[ "$configured_tmp" != /* ]]; then
        configured_tmp="$PROJECT_ROOT/$configured_tmp"
    fi
    if [[ -d "$configured_tmp" && "$configured_tmp" != "$PROJECT_ROOT/build" && "$configured_tmp" != "$PROJECT_ROOT/build/"* ]]; then
        search_roots+=("$configured_tmp")
    fi
fi
MODULE_FILE=""
if (( LAST_STEP >= 7 )) && [[ -s "$IMAGES/$MODULE_NAME.ko" ]]; then
    MODULE_FILE="$IMAGES/$MODULE_NAME.ko"
else
MODULE_FILE=""
while IFS= read -r -d '' candidate; do
    if [[ -n "$MODULE_FILE" ]] && ! cmp -s "$MODULE_FILE" "$candidate"; then
        error 'Different deployed modules were found. Review the build outputs before packaging.'
    fi
    MODULE_FILE=$candidate
done < <(find "${search_roots[@]}" -path '*/deploy/images/*' -name "$MODULE_NAME.ko" \( -type f -o -type l \) -print0)
if [[ -z "$MODULE_FILE" || ! -r "$MODULE_FILE" || ! -s "$MODULE_FILE" ]]; then
    error 'The module build finished, but its deployed .ko was not found.'
fi

fi

WRAPPER="$PROJECT_ROOT/${PROJECT_NAME}_wrapper"
IMAGES="$PROJECT_ROOT/images/linux"
if (( LAST_STEP < 8 )); then
    CURRENT_STEP=8
mkdir -p "$WRAPPER/code" "$WRAPPER/fpga"
cp -- "$MODULE_DIR/files/$MODULE_NAME.c" "$MODULE_DIR/files/$MODULE_NAME.h" "$WRAPPER/code/"
if [[ ! "$MODULE_FILE" -ef "$IMAGES/$MODULE_NAME.ko" ]]; then
    cp -- "$MODULE_FILE" "$IMAGES/$MODULE_NAME.ko"
fi
if [[ ! "$MODULE_FILE" -ef "$WRAPPER/fpga/$MODULE_NAME.ko" ]]; then
    cp -- "$MODULE_FILE" "$WRAPPER/fpga/"
fi
for file in "$BITSTREAM" "$PL_BINARY"; do
    name=${file##*/}
    if [[ ! "$file" -ef "$WRAPPER/fpga/$name" ]]; then
        cp -- "$file" "$WRAPPER/fpga/$name"
    fi
done
    checkpoint 8
fi

if (( LAST_STEP < 9 )); then
    CURRENT_STEP=9
OVERLAY_DTS="$PROJECT_ROOT/components/plnx_workspace/device-tree/pl-overlay-full/pl.dtsi"
if [[ ! -r "$OVERLAY_DTS" || ! -s "$OVERLAY_DTS" ]]; then
    error "Requested overlay source is missing after the build: $OVERLAY_DTS"
fi
if ! grep -Eq '^[[:space:]]*/plugin/[[:space:]]*;' "$OVERLAY_DTS"; then
    error 'The requested pl.dtsi is not a standalone /plugin/ overlay.'
fi
cp -- "$OVERLAY_DTS" "$WRAPPER/fpga/pl.dtsi"

# Compile the original overlay, without adding cells or removing firmware-name.
if command -v dtc >/dev/null; then
    DTC=$(command -v dtc)
else
    DTC="${PETALINUX:-/opt/petalinux/2025.1}/sysroots/x86_64-petalinux-linux/usr/bin/dtc"
fi
if [[ ! -x "$DTC" ]]; then
    error 'dtc is required to compile the original PL overlay.'
fi
section 'Compiling the original PL overlay without changing its properties.'
"$DTC" -@ -I dts -O dtb -i "$(dirname -- "$OVERLAY_DTS")" \
    -o "$WRAPPER/fpga/pl.dtbo" "$OVERLAY_DTS"

    checkpoint 9
fi

# Export the manual FPGA/overlay/module loader even on a completed --resume.
section 'Exporting the manual FPGA programming script.'
mkdir -p "$WRAPPER/fpga"
cat > "$WORK_DIR/program_fpga.sh" <<'UNIFIED_PROGRAM_FPGA_EOF'
#!/usr/bin/env bash
# Apply an optional PL overlay, then insert a kernel module on the KR260.
# Check FPGA Manager state; program a full PL .bin only when not operating.
# Usage: sudo bash program_fpga.sh [-b FILE.bin] [-k FILE.ko] [-n DRIVER] [-o FILE.dtbo] [-f]
# Missing -k/-o inputs are searched beside this script, then requested if needed.
# -n refers to the driver, not the overlay. It may be written with or without .ko.
# The overlay instance name is derived from the selected driver filename.
# -f replaces an existing overlay instance; it does not unload a loaded driver.
# An overlay containing firmware-name can itself request FPGA programming.
set -Eeuo pipefail

info() { printf '[INFO] %s\n' "$*"; }
ok() { printf '[OK] %s\n' "$*"; }
die() { printf '[ERROR] %s\n' "$*" >&2; exit 1; }
usage() {
    cat <<'HELP'
Usage:
  sudo bash program_fpga.sh [-b FILE.bin] [-k FILE.ko] [-n DRIVER] [-o FILE.dtbo] [-f]

  -b FILE    Full PL bitstream; used only if FPGA Manager is not operating
  -k FILE    Kernel module to insert; its filename supplies the driver name
  -n NAME    Driver name, with or without .ko; search for NAME.ko beside this script
  -o FILE    Optional PL device-tree overlay to apply before inserting the module
  -f         Replace the existing overlay instance named after the driver
  -h         Display help

Omitted files are searched in the script directory, not the working directory.
A unique readable, nonempty .ko/.dtbo is selected automatically. Otherwise,
the script requests the path until valid. Enter skips the optional overlay.
Explicit relative paths and paths entered at prompts use the working directory.
With both options, -n must match the filename passed through -k.
Check fpga0/state before applying the overlay and inserting the module.
If operating, skip explicit bitstream loading. Otherwise use -b, search for a
single .bin beside the script (excluding BOOT.BIN), or request its path.
Operating does not identify the loaded design; it must match this driver.
An overlay with firmware-name may itself request programming.

Examples:
  sudo bash program_fpga.sh -o pl.dtbo
  sudo bash program_fpga.sh -n dcctv33p20251driver -o pl.dtbo
  sudo bash program_fpga.sh -k /home/petalinux/mydriver.ko -o pl.dtbo
HELP
}

MODULE_PATH=
BITSTREAM_PATH=
DRIVER_NAME=
OVERLAY_PATH=
FORCE_RELOAD=false
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
while getopts ':b:k:n:o:fh' opt; do
    case "$opt" in
        b) BITSTREAM_PATH=$OPTARG ;;
        k) MODULE_PATH=$OPTARG ;;
        n) DRIVER_NAME=$OPTARG ;;
        o) OVERLAY_PATH=$OPTARG ;;
        f) FORCE_RELOAD=true ;;
        h) usage; exit 0 ;;
        :) die "Option -$OPTARG requires an argument." ;;
        \?) die "Unknown option: -$OPTARG. Use -h for help." ;;
    esac
done
shift "$((OPTIND - 1))"
(( $# == 0 )) || die 'Unexpected positional arguments. Use -h for help.'

require_file() {
    [[ -f "$1" && -r "$1" && -s "$1" ]] || die "Missing, unreadable or empty file: $1"
}

select_input_file() {
    local variable=$1 extension=$2 description=$3 optional=$4 expected=${5:-}
    local value=${!1} candidate filename
    local -a matches=()
    if [[ -z "$value" ]]; then
        for candidate in "$SCRIPT_DIR"/*; do
            [[ -f "$candidate" && -r "$candidate" && -s "$candidate" ]] || continue
            filename=${candidate##*/}
            [[ "$filename" == *".$extension" ]] || continue
            [[ "$extension" != bin || "${filename,,}" != boot.bin ]] || continue
            [[ -z "$expected" || "$filename" == "$expected.$extension" ]] || continue
            matches+=("$candidate")
        done
        if ((${#matches[@]} == 1)); then
            value=${matches[0]}
            info "Found $description beside the script: $value"
        else
            info "Found ${#matches[@]} matching $description files in $SCRIPT_DIR. Specify the intended file."
            if ((${#matches[@]} > 1)); then printf '  %s\n' "${matches[@]}"; fi
        fi
    fi
    while true; do
        if [[ "$value" == '~/'* ]]; then value="$HOME/${value:2}"; fi
        if [[ -n "$value" ]]; then
            filename=${value##*/}
            if [[ -f "$value" && -r "$value" && -s "$value" && "$filename" == *".$extension" ]]; then
                if [[ "$extension" == bin && "${filename,,}" == boot.bin ]]; then
                    printf '[ERROR] BOOT.BIN is boot firmware, not the PL bitstream.\n' >&2
                    value=
                    continue
                fi
                if [[ -z "$expected" || "$filename" == "$expected.$extension" ]]; then
                    if [[ "$extension" != ko || "${filename%.ko}" =~ ^[A-Za-z_][A-Za-z0-9_-]*$ ]]; then
                        printf -v "$variable" '%s' "$value"
                        return
                    fi
                fi
            fi
            printf '[ERROR] Invalid %s file: %s' "$description" "$value" >&2
            if [[ -n "$expected" ]]; then printf ' (expected %s.%s)' "$expected" "$extension" >&2; fi
            printf '\n' >&2
        fi
        if [[ "$optional" == yes ]]; then
            printf '%s path (Enter to skip): ' "$description" >&2
        else
            printf '%s path: ' "$description" >&2
        fi
        IFS= read -r value || die 'Input ended before file selection was completed.'
        value=${value%$'\r'}
        if [[ -z "$value" && "$optional" == yes ]]; then
            printf -v "$variable" '%s' ''
            info 'Overlay loading skipped.'
            return
        fi
    done
}

select_module() {
    local filename detected
    DRIVER_NAME=${DRIVER_NAME%.ko}
    if [[ -n "$DRIVER_NAME" ]]; then
        [[ "$DRIVER_NAME" =~ ^[A-Za-z_][A-Za-z0-9_-]*$ ]] || die 'Invalid driver name for -n.'
    fi
    select_input_file MODULE_PATH ko 'Kernel module' no "$DRIVER_NAME"
    require_file "$MODULE_PATH"
    filename=${MODULE_PATH##*/}
    [[ "$filename" == *.ko ]] || die 'The module file must have the .ko extension.'
    detected=${filename%.ko}
    [[ "$detected" =~ ^[A-Za-z_][A-Za-z0-9_-]*$ ]] || die 'Invalid module filename.'
    [[ -z "$DRIVER_NAME" || "$DRIVER_NAME" == "$detected" ]] || die "-n does not match the module filename: $detected"
    DRIVER_NAME=$detected
    ok "Driver name: $DRIVER_NAME"
    info "Module file: $MODULE_PATH"
}

ensure_configfs() {
    [[ -d /sys/kernel/config ]] || die 'Kernel configfs support is unavailable.'
    if ! mountpoint -q /sys/kernel/config; then
        info 'Mounting configfs.'
        mount -t configfs configfs /sys/kernel/config
    fi
    [[ -d /sys/kernel/config/device-tree/overlays ]] || die 'Device-tree overlay configfs support is unavailable.'
}

read_fpga_state() {
    local state_file=/sys/class/fpga_manager/fpga0/state state
    [[ -r "$state_file" ]] || die "FPGA Manager state is unavailable: $state_file"
    IFS= read -r state < "$state_file" || die 'Cannot read FPGA Manager state.'
    printf '%s' "$state"
}

ensure_fpga_programmed() {
    local state
    state=$(read_fpga_state) || die 'Cannot determine FPGA Manager state.'
    printf '\n'
    info "FPGA Manager state: $state"
    if [[ "$state" == operating ]]; then
        ok 'FPGA is already operating; skipping explicit bitstream programming.'
        info 'This state does not verify which design is currently loaded.'
        return
    fi
    case "$state" in
        'firmware request'|'write init'|'write'|'write complete')
            die 'FPGA Manager is busy programming. Wait for the current operation to finish.' ;;
    esac
    command -v fpgautil >/dev/null || die 'fpgautil is required to program the FPGA.'
    select_input_file BITSTREAM_PATH bin 'PL bitstream (not BOOT.BIN)' no
    info "Programming FPGA: $BITSTREAM_PATH"
    if ! fpgautil -b "$BITSTREAM_PATH"; then
        die 'FPGA programming failed. Inspect dmesg; the driver has not been inserted.'
    fi
    state=$(read_fpga_state) || die 'Cannot verify the FPGA state after programming.'
    [[ "$state" == operating ]] || die "FPGA did not reach operating state: $state"
    ok 'FPGA programming completed; state=operating.'
}

load_overlay() {
    local directory="/sys/kernel/config/device-tree/overlays/$DRIVER_NAME"
    # Write the DTBO directly through configfs; no firmware directory copy needed.
    if [[ -d "$directory" ]]; then
        [[ "$FORCE_RELOAD" == true ]] || die "Overlay $DRIVER_NAME already exists. Use -f to replace it."
        info "Removing overlay instance: $DRIVER_NAME"
        rmdir "$directory"
    fi
    info "Applying overlay: $OVERLAY_PATH"
    mkdir "$directory"
    if ! cat -- "$OVERLAY_PATH" > "$directory/dtbo"; then
        rmdir "$directory" || true
        die 'Overlay application failed. Inspect dmesg for details.'
    fi
    if [[ -r "$directory/status" ]]; then
        local status
        read -r status < "$directory/status"
        [[ "$status" == applied ]] || die "Unexpected overlay status: $status"
    fi
    ok "Overlay applied: $DRIVER_NAME"
}

main() {
    select_module
    select_input_file OVERLAY_PATH dtbo 'PL overlay' yes
    (( EUID == 0 )) || die 'Run this script as root, or use sudo.'
    command -v insmod >/dev/null || die 'insmod is unavailable.'
    local module_sysname=${DRIVER_NAME//-/_}
    [[ ! -d "/sys/module/$module_sysname" ]] || die "Driver already loaded: $DRIVER_NAME. Unload it explicitly before replacing its overlay."
    ensure_fpga_programmed
    if [[ -n "$OVERLAY_PATH" ]]; then
        require_file "$OVERLAY_PATH"
        ensure_configfs
        printf '\n'
        load_overlay
    fi
    printf '\n'
    info "Inserting kernel module: $MODULE_PATH"
    if ! insmod "$MODULE_PATH"; then
        die 'Module insertion failed. Inspect dmesg; an applied overlay is left in place.'
    fi
    ok "Driver loaded: $DRIVER_NAME"
}

main
UNIFIED_PROGRAM_FPGA_EOF
if ! cmp -s "$WORK_DIR/program_fpga.sh" "$WRAPPER/fpga/program_fpga.sh"; then
    cp -- "$WORK_DIR/program_fpga.sh" "$WRAPPER/fpga/program_fpga.sh"
fi
chmod +x "$WRAPPER/fpga/program_fpga.sh"
success "Manual FPGA loader: $WRAPPER/fpga/program_fpga.sh"

if (( LAST_STEP < 10 )); then
    CURRENT_STEP=10
if [[ "$NO_STARTUP" == true ]]; then
    info 'Skipping startupbash creation and automatic systemd selection (--no-startup).'
else
# Create the startup application after the module and overlay have been built.
# Its installation and systemd selection are the only automatic settings.
section 'Preparing automatic FPGA, overlay and driver startup.'
STARTUP_DIR="$PROJECT_ROOT/project-spec/meta-user/recipes-apps/startupbash"
if [[ ! -d "$STARTUP_DIR" ]]; then
    petalinux-create apps --template install --name startupbash
fi
cp -- "$PL_BINARY" "$STARTUP_DIR/files/design.bin"
cp -- "$WRAPPER/fpga/pl.dtbo" "$STARTUP_DIR/files/pl.dtbo"
cp -- "$MODULE_FILE" "$STARTUP_DIR/files/driver.ko"

# If the overlay requests firmware, let FPGA Manager load that exact filename.
# Otherwise, program the selected binary explicitly before applying the overlay.
"$DTC" -I dtb -O dts -o "$WORK_DIR/overlay-check.dts" "$WRAPPER/fpga/pl.dtbo"
mapfile -t firmware_names < <(sed -n 's/^[[:space:]]*firmware-name = "\([^"]*\)";[[:space:]]*$/\1/p' "$WORK_DIR/overlay-check.dts" | sort -u)
firmware_count=$(grep -cE '^[[:space:]]*firmware-name[[:space:]]*=' "$WORK_DIR/overlay-check.dts" || true)
if (( firmware_count != ${#firmware_names[@]} || firmware_count > 1 )); then
    error 'This startup supports one full PL bitstream; multiple firmware-name values were found.'
fi
OVERLAY_LOADS_FIRMWARE=no
FIRMWARE_NAME="kr260-startup/design.bin"
if (( ${#firmware_names[@]} == 1 )); then
    FIRMWARE_NAME=${firmware_names[0]}
    OVERLAY_LOADS_FIRMWARE=yes
fi
if [[ ! "$FIRMWARE_NAME" =~ ^[A-Za-z0-9_][A-Za-z0-9_./-]*\.bin$ || "/$FIRMWARE_NAME/" == *'/../'* || "/$FIRMWARE_NAME/" == *'/./'* || "${FIRMWARE_NAME##*/}" == 'BOOT.BIN' ]]; then
    error "Unsupported firmware filename in overlay: $FIRMWARE_NAME"
fi

cat > "$STARTUP_DIR/files/startupbash" <<'STARTUP'
#!/usr/bin/env bash
# Program the matching PL design, apply the overlay and insert the driver.
# Console, bootargs and firmware settings are not modified.
set -Eeuo pipefail

# Use colors only on terminals. NO_COLOR also disables them explicitly.
MSG_BLUE=""
MSG_CYAN=""
MSG_GREEN=""
MSG_RESET=""
MSG_ERROR_RED=""
MSG_ERROR_RESET=""
if [[ -t 1 && "${TERM:-dumb}" != dumb && -z "${NO_COLOR+x}" ]]; then
    MSG_BLUE=$'\033[1;34m'
    MSG_CYAN=$'\033[36m'
    MSG_GREEN=$'\033[1;32m'
    MSG_RESET=$'\033[0m'
fi
if [[ -t 2 && "${TERM:-dumb}" != dumb && -z "${NO_COLOR+x}" ]]; then
    MSG_ERROR_RED=$'\033[1;31m'
    MSG_ERROR_RESET=$'\033[0m'
fi

info() {
    printf '%s[INFO]%s %s\n' "$MSG_CYAN" "$MSG_RESET" "$*"
}

success() {
    printf '%s[OK]%s %s\n' "$MSG_GREEN" "$MSG_RESET" "$*"
}

section() {
    printf '\n%s================================================================\n' "$MSG_BLUE"
    printf '[STEP] %s\n' "$*"
    printf '================================================================%s\n\n' "$MSG_RESET"
}

print_error() {
    printf '\n%s----------------------------------------------------------------\n' "$MSG_ERROR_RED" >&2
    printf '[ERROR] %s\n' "$*" >&2
    printf '%s\n' "----------------------------------------------------------------${MSG_ERROR_RESET}" >&2
}

error() {
    print_error "$*"
    exit 1
}

on_error() {
    local status=$1
    local line=$2
    print_error "Command failed at line $line (exit code $status)."
    return "$status"
}

trap 'on_error "$?" "$LINENO"' ERR

DATA_DIR="@DATA_DIR@"
BITSTREAM="@FIRMWARE_FILE@"
MODULE="@MODULE@"
OVERLAY_LOADS_FIRMWARE="@OVERLAY_LOADS_FIRMWARE@"
OVERLAY=/sys/kernel/config/device-tree/overlays/kr260-startup
STATE_FILE=/sys/class/fpga_manager/fpga0/state

if (( EUID != 0 )); then error 'Run as root.'; fi
for tool in fpgautil mount mountpoint insmod; do
    if ! command -v "$tool" >/dev/null; then error "Missing command: $tool"; fi
done
for file in "$BITSTREAM" "$DATA_DIR/pl.dtbo" "$DATA_DIR/driver.ko"; do
    if [[ ! -r "$file" || ! -s "$file" ]]; then error "Missing or empty startup file: $file"; fi
done
if [[ ! -r "$STATE_FILE" ]]; then error 'FPGA Manager is unavailable.'; fi
if [[ -d "/sys/module/${MODULE//-/_}" ]]; then error 'Driver already loaded; refusing to reprogram active hardware.'; fi
read -r state < "$STATE_FILE"
case "$state" in
    'firmware request'|'write init'|'write'|'write complete') error 'FPGA Manager is busy.' ;;
esac
if [[ ! -d /sys/kernel/config ]]; then error 'Kernel configfs support is unavailable.'; fi
if ! mountpoint -q /sys/kernel/config; then
    mount -t configfs configfs /sys/kernel/config
fi
if [[ ! -d /sys/kernel/config/device-tree/overlays ]]; then error 'Kernel overlay support is unavailable.'; fi
if [[ -e "$OVERLAY" ]]; then error 'Startup overlay already exists.'; fi

if [[ "$OVERLAY_LOADS_FIRMWARE" == no ]]; then
    section "Programming FPGA: $BITSTREAM"
    fpgautil -b "$BITSTREAM"
    read -r state < "$STATE_FILE"
    if [[ "$state" != operating ]]; then error "Unexpected FPGA state: $state"; fi
else
    info 'The overlay will request the packaged FPGA firmware.'
fi
section 'Applying the PL overlay'
mkdir "$OVERLAY"
if ! cat "$DATA_DIR/pl.dtbo" > "$OVERLAY/dtbo"; then
    rmdir "$OVERLAY" || true
    error 'Overlay application failed; driver not inserted.'
fi
if [[ -r "$OVERLAY/status" ]]; then
    read -r status < "$OVERLAY/status"
    if [[ "$status" != applied ]]; then error "Unexpected overlay status: $status"; fi
fi
read -r state < "$STATE_FILE"
if [[ "$state" != operating ]]; then error "Unexpected FPGA state after overlay: $state"; fi
section "Inserting driver: $MODULE"
insmod "$DATA_DIR/driver.ko"
success 'FPGA, overlay and driver startup completed.'
STARTUP
sed -i -e "s|@MODULE@|$MODULE_NAME|g" \
    -e "s|@OVERLAY_LOADS_FIRMWARE@|$OVERLAY_LOADS_FIRMWARE|g" "$STARTUP_DIR/files/startupbash"
chmod +x "$STARTUP_DIR/files/startupbash"
cat > "$STARTUP_DIR/files/startupbash.service" <<'SERVICE'
[Unit]
Description=KR260 FPGA, overlay and driver initialization
After=local-fs.target systemd-udev-trigger.service
Before=multi-user.target

[Service]
Type=oneshot
User=root
ExecStart=/bin/bash /usr/bin/startupbash
RemainAfterExit=yes
TimeoutStartSec=180
StandardOutput=journal+console
StandardError=journal+console

[Install]
WantedBy=multi-user.target
SERVICE
cat > "$STARTUP_DIR/startupbash.bb" <<'STARTUP_RECIPE'
SUMMARY = "Automatic KR260 FPGA, overlay and driver startup"
LICENSE = "CLOSED"
SRC_URI = "file://startupbash file://startupbash.service file://design.bin file://pl.dtbo file://driver.ko"
S = "${WORKDIR}"
inherit systemd features_check
REQUIRED_DISTRO_FEATURES = "systemd"
RDEPENDS:${PN} += "bash fpga-manager-script kmod util-linux-mount util-linux-mountpoint"
PACKAGE_ARCH = "${MACHINE_ARCH}"
SYSTEMD_SERVICE:${PN} = "startupbash.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"
INHIBIT_PACKAGE_STRIP = "1"
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
FIRMWARE_NAME = "@FIRMWARE_NAME@"
do_install() {
    install -d ${D}${bindir} ${D}${systemd_system_unitdir} ${D}${datadir}/kr260-startup
    install -D -m 0644 ${WORKDIR}/design.bin ${D}${nonarch_base_libdir}/firmware/${FIRMWARE_NAME}
    install -m 0755 ${WORKDIR}/startupbash ${D}${bindir}/startupbash
    sed -i -e 's|@DATA_DIR@|${datadir}/kr260-startup|g' \
        -e 's|@FIRMWARE_FILE@|${nonarch_base_libdir}/firmware/${FIRMWARE_NAME}|g' ${D}${bindir}/startupbash
    install -m 0644 ${WORKDIR}/startupbash.service ${D}${systemd_system_unitdir}/startupbash.service
    install -m 0644 ${WORKDIR}/pl.dtbo ${WORKDIR}/driver.ko ${D}${datadir}/kr260-startup/
}
FILES:${PN} += "${systemd_system_unitdir}/startupbash.service ${datadir}/kr260-startup ${nonarch_base_libdir}/firmware/${FIRMWARE_NAME}"
STARTUP_RECIPE
sed -i "s|@FIRMWARE_NAME@|$FIRMWARE_NAME|g" "$STARTUP_DIR/startupbash.bb"

# Apply only the explicitly requested exception to menu-based configuration.
section 'Enabling startupbash and selecting systemd automatically.'
ROOTFS_CONFIG="$PROJECT_ROOT/project-spec/configs/rootfs_config"
if [[ ! -f "$ROOTFS_CONFIG" || -L "$ROOTFS_CONFIG" ]]; then
    error 'The root filesystem configuration is missing or is a symlink.'
fi
# Remove only the startup selection and the init-manager choice entries.
sed -E -i '/^(# )?CONFIG_startupbash(=| is not set$)/d; /^(# )?CONFIG_[Ii]nit-manager-[[:alnum:]_-]+(=| is not set$)/d' "$ROOTFS_CONFIG"
printf '%s\n' 'CONFIG_startupbash=y' 'CONFIG_Init-manager-systemd=y' >> "$ROOTFS_CONFIG"
petalinux-config -c rootfs --silentconfig
if ! grep -qx 'CONFIG_startupbash=y' "$ROOTFS_CONFIG"; then
    error 'PetaLinux did not preserve the startupbash selection.'
fi
if ! grep -qx 'CONFIG_Init-manager-systemd=y' "$ROOTFS_CONFIG"; then
    error 'PetaLinux did not preserve the systemd selection.'
fi
fi
    checkpoint 10
fi

if (( LAST_STEP < 11 )); then
    CURRENT_STEP=11
if [[ "$NO_STARTUP" == true ]]; then
    info 'No startup application added; keeping the completed base system build.'
else
    section 'Rebuilding the complete image with automatic startup.'
    petalinux-build
    success 'System build completed.'
fi

    checkpoint 11
fi

if (( LAST_STEP < 12 )); then
    CURRENT_STEP=12
section 'Packaging BOOT.BIN from the components generated by this build.'
for file in zynqmp_fsbl.elf pmufw.elf bl31.elf u-boot.elf; do
    if [[ ! -r "$IMAGES/$file" || ! -s "$IMAGES/$file" ]]; then
        error "Missing boot component: $file. Review the project configuration."
    fi
done
petalinux-package boot --format BIN \
    --fsbl "$IMAGES/zynqmp_fsbl.elf" \
    --pmufw "$IMAGES/pmufw.elf" \
    --atf "$IMAGES/bl31.elf" \
    --u-boot "$IMAGES/u-boot.elf" \
    --output "$WORK_DIR/BOOT.BIN"
if [[ ! -s "$WORK_DIR/BOOT.BIN" ]]; then
    error 'BOOT.BIN was not generated.'
fi
cp -- "$WORK_DIR/BOOT.BIN" "$IMAGES/BOOT.BIN"

    checkpoint 12
fi

# Export boot files even when step 12 was already completed before --resume.
section 'Copying boot files to the wrapper FPGA directory.'
mkdir -p "$WRAPPER/fpga"
for file in BOOT.BIN zynqmp_fsbl.elf; do
    if [[ ! -r "$IMAGES/$file" || ! -s "$IMAGES/$file" ]]; then
        error "Cannot export missing or empty boot file: $IMAGES/$file"
    fi
    if [[ ! "$IMAGES/$file" -ef "$WRAPPER/fpga/$file" ]]; then
        cp -- "$IMAGES/$file" "$WRAPPER/fpga/$file"
    fi
    success "Boot file copied: $WRAPPER/fpga/$file"
done

if (( LAST_STEP < 13 )); then
    CURRENT_STEP=13
# Use the root filesystem mode chosen in the project menu.
if [[ ! -r "$IMAGES/rootfs.tar.gz" || ! -s "$IMAGES/rootfs.tar.gz" ]]; then
    error 'rootfs.tar.gz is missing. Enable it in the project menu and rebuild.'
fi
boot_files=(BOOT.BIN boot.scr Image system.dtb)
if grep -qx 'CONFIG_SUBSYSTEM_ROOTFS_INITRD=y' "$PROJECT_ROOT/project-spec/configs/config"; then
    ramdisk_found=false
    for file in rootfs.cpio.gz.u-boot ramdisk.cpio.gz.u-boot ramdisk.cpio.gz rootfs.cpio.gz; do
        if [[ -r "$IMAGES/$file" && -s "$IMAGES/$file" ]]; then
            boot_files+=("$file")
            ramdisk_found=true
        fi
    done
    if [[ "$ramdisk_found" == false ]]; then
        error 'INITRD is selected, but no generated ramdisk was found.'
    fi
fi
for file in "$BITSTREAM" "$PL_BINARY"; do
    name=${file##*/}
    cp -- "$file" "$IMAGES/$name"
    boot_files+=("$name")
done
for file in "${boot_files[@]}"; do
    if [[ ! -r "$IMAGES/$file" || ! -s "$IMAGES/$file" ]]; then
        error "Missing boot file: $file"
    fi
done
boot_files_list=$(IFS=,; printf '%s' "${boot_files[*]}")
section 'Creating the WIC image with the default PetaLinux partition layout.'
petalinux-package wic \
    --images-dir "$IMAGES" \
    --rootfs-file "$IMAGES/rootfs.tar.gz" \
    --bootfiles "$boot_files_list" \
    --outdir "$WORK_DIR/wic"
if [[ ! -s "$WORK_DIR/wic/petalinux-sdimage.wic" ]]; then
    error 'The WIC image was not generated.'
fi
cp -- "$WORK_DIR/wic/petalinux-sdimage.wic" "$IMAGES/petalinux-sdimage.wic"
cp -- "$WORK_DIR/wic/petalinux-sdimage.wic" "$WRAPPER/"

    checkpoint 13
fi

# Verify the persistent deliverables before reporting success.
if [[ ! -x "$WRAPPER/fpga/program_fpga.sh" ]]; then
    error "Manual FPGA loader is missing or is not executable: $WRAPPER/fpga/program_fpga.sh"
fi
for file in "$IMAGES/BOOT.BIN" "$IMAGES/petalinux-sdimage.wic" "$WRAPPER/petalinux-sdimage.wic" "$WRAPPER/fpga/pl.dtbo" "$WRAPPER/fpga/BOOT.BIN" "$WRAPPER/fpga/zynqmp_fsbl.elf"; do
    if [[ ! -s "$file" ]]; then error "A completed output is missing: $file"; fi
done
section 'Completed'
success "Project ready: $PROJECT_ROOT"
info 'Resume command (from the parent directory):'
printf '  bash %q -n %q --resume\n' "$SCRIPT_DIR/unified_ptlx_prj.sh" "$PROJECT_NAME"
printf 'WIC: %s\n' "$WRAPPER/petalinux-sdimage.wic"
printf 'Driver sources: %s\n' "$WRAPPER/code"
printf 'FPGA and driver files: %s\n' "$WRAPPER/fpga"
if [[ "$NO_STARTUP" == true ]]; then
    info 'Automatic startup disabled; use fpga/program_fpga.sh on the board for manual loading.'
else
    printf 'Automatic startup: startupbash.service (startupbash and systemd enabled automatically).\n'
fi
