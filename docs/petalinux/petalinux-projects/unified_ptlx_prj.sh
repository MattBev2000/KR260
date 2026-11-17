#!/usr/bin/env bash
# Create a PetaLinux 2025.1 project, driver and WIC with automatic KR260 startup.
# Generates its startup script and service internally: FPGA -> overlay -> module.
# See --help. Requires matching hardware and kernel FPGA/configfs overlay support.
set -Eeuo pipefail

# =============================================================================
# Console output and error handling
# =============================================================================
# Use colors only on interactive terminals; respect NO_COLOR and TERM=dumb.

log() {
    local level=$1
    local color=$2
    local stream=$3
    shift 3

    if [[ -t "$stream" && "${TERM:-dumb}" != dumb && -z "${NO_COLOR+x}" ]]; then
        printf '\033[%sm[%s] %s\033[0m\n' "$color" "$level" "$*" >&"$stream"
    else
        printf '[%s] %s\n' "$level" "$*" >&"$stream"
    fi
}

info() {
    log INFO 36 1 "$@"
}

ok() {
    log OK 32 1 "$@"
}

error() {
    log ERROR 31 2 "$@"
}

section() {
    printf '\n'
    info "========== $* =========="
    printf '\n'
}

die() {
    error "$*"
    exit 1
}

on_error() {
    local status=$1
    local line=$2

    error "Command failed at line $line (exit status $status)."
    exit "$status"
}

trap 'on_error "$?" "$LINENO"' ERR

# =============================================================================
# Help and file helpers
# =============================================================================
usage() {
    cat <<'HELP'
Usage:
  ./create_ptlnx_all.sh -n NAME -sdt DIR [-bsp FILE] [-cfg DIR] [options]

Options:
  -n NAME           Project directory name, relative to the launch directory
  -sdt DIR          Vivado/Vitis 2025.1 SDT directory, containing one .bit
                    and one .bin file (subdirectories are searched too)
  -bsp FILE         PetaLinux 2025.1 board BSP; otherwise search beside this
                    script, select if several exist, or ask if none is found
  -cfg DIR          Search for config, rootfs_config and kernel user.cfg
                    Each file is optional: found -> silent; missing -> menu
  --settings FILE   Default: /opt/petalinux/2025.1/settings.sh
  -gen DIR          Generator/templates directory; default:
                    /opt/petalinux/docs/driver_generation
  --driver-name NAME
                    Override the driver name derived from the project directory
  --force-driver    Overwrite/rebuild an existing driver and its wrapper outputs
  -h, --h, --help   Display this help and exit without changing anything

Examples:
  ./create_ptlnx_all.sh -n my-project -sdt /path/to/SDT
  ./create_ptlnx_all.sh -n my-project -sdt /path/to/SDT \
    -bsp /path/to/board.bsp -cfg /path/to/saved-configs

Workflow:
  1. Source the PetaLinux 2025.1 settings.
  2. Create the project from the board BSP.
  3. Run petalinux-config --get-hw-description with the SDT directory.
  4. Configure the kernel, then build the base project.
  5. Configure rootfs, then generate/build and enable the driver.
  6. Run petalinux-build.
  7. Run petalinux-package boot.
  8. Run petalinux-package wic, including BOOT.BIN in the boot partition.

Without -cfg, project, kernel and rootfs configuration menus are interactive.
With -cfg, select silent or interactive mode separately for each configuration:
config controls the project menu, rootfs_config controls the rootfs menu,
and user.cfg controls the kernel menu. Missing files open their respective menu.
Present files must be readable and nonempty; duplicate locations are rejected.
The network sstate mirror is automatically enabled and set to:
  https://edf.amd.com/sswreleases/rel-v2025.1/aarch64/sstate-cache
BB NO NETWORK is disabled so the mirror can be accessed. These settings are
applied to project-spec/configs/config before each build, including imported
-cfg configurations. Other menu selections are preserved.
Kernel configuration uses petalinux-config -c kernel --silentconfig when
user.cfg is supplied through -cfg. Otherwise it opens the kernel menu.
Kernel compilation is handled by the full system build.
Startup is always generated internally after driver compilation and included in
rootfs before packaging the WIC. No external startup script is accepted.
At boot startupbash.service programs the FPGA, applies pl.dtbo without
firmware-name, then inserts the compiled driver. Failures stop the sequence.
Output goes to journal and console. The rootfs must use systemd; the kernel
must support ZynqMP FPGA Manager and device-tree overlays through configfs.
Do not enable another service that programs the same FPGA or loads this driver.
Inspect: systemctl status startupbash.service; journalctl -u startupbash.service -b.
The generated recipe stages bitstream, overlay and module inside the rootfs;
SD mounting and interactive file selection are not needed at boot.

The -cfg directory accepts config and rootfs_config either directly or under
project-spec/configs/. An optional kernel user.cfg is accepted directly or
under project-spec/meta-user/recipes-kernel/linux/linux-xlnx/.
All explicit relative paths are resolved before entering the project.

Enable rootfs.tar.gz in Image Packaging Configuration for WIC creation.
The boot partition contains BOOT.BIN, boot.scr, Image, system.dtb and the original .bit and .bin
found recursively in the SDT directory. Exactly one nonempty .bit and one
nonempty .bin are required. Both are copied unchanged, with their original
filenames, into <project>/<project>_wrapper/fpga/.
The WIC stays at the wrapper root; driver .c/.h go into code/.
The fpga/ directory also holds .ko, corrected pl.dtsi, pl.dtbo and executable
program_fpga.sh. The overlay uses the matching bitstream loaded at boot.
The enabled driver recipe is included by the final full rootfs build.
Driver generation and automatic startup installation run after rootfs configuration.
The final system build includes both before packaging.
Copying the .bit does not automatically program the FPGA.
INITRD files are included when that mode is selected in the project config.

The WIC is saved as images/linux/petalinux-sdimage.wic and copied to
<project>/<project>_wrapper/petalinux-sdimage.wic.
By default, generate a new BOOT.BIN using the project's zynqmp_fsbl.elf,
pmufw.elf, bl31.elf and u-boot.elf after the final build. Missing components
stop packaging. An old BOOT.BIN is not silently reused. No --fpga option is
passed; the bitstream is copied separately into the WIC as described above.
BOOT.BIN is saved in images/linux/ and included in the WIC boot partition.
It is not exported as a separate file into <project>/<project>_wrapper/.
The script does not write an SD card or QSPI firmware.
Including BOOT.BIN in the WIC does not change the board's boot mode.
Use compatible board firmware, a 2025.1 board BSP and matching SDT hardware.
HELP
}

# Accept flat or previous-project configurations; reject ambiguous duplicates.
find_config() {
    local flat=$1
    local nested=$2
    local required=$3
    local candidate
    local selected=
    local count=0

    for candidate in "$CFG_DIR/$flat" "$CFG_DIR/$nested"; do
        if [[ -e "$candidate" || -L "$candidate" ]]; then
            if [[ ! -f "$candidate" || ! -r "$candidate" || ! -s "$candidate" ]]; then
                die "Unreadable or empty configuration: $candidate"
            fi

            selected=$candidate
            count=$((count + 1))
        fi
    done

    if ((count > 1)); then
        die "Both $flat and $nested exist in $CFG_DIR; keep one."
    fi

    if ((count == 0)) && [[ "$required" == yes ]]; then
        die "Missing configuration: $flat (or $nested) in $CFG_DIR"
    fi

    printf '%s' "$selected"
}

# Copy saved configuration text and normalize line endings only in the copy.
import_config() {
    local source=$1
    local destination=$2

    mkdir -p "${destination%/*}"
    cp -- "$source" "$destination"
    sed -i 's/\r$//' "$destination"

    ok "Imported: $source"
}

# Read literal input without evaluating it as a shell expression.
ask() {
    local variable=$1
    local prompt=$2
    local default=${3:-}
    local answer

    if [[ ! -t 0 ]]; then
        die "Interactive input required: $prompt. Supply the corresponding option."
    fi

    printf '\n'
    if ! read -r -p "$prompt" answer; then
        die 'Input cancelled.'
    fi
    printf '\n'

    answer=${answer%$'\r'}
    printf -v "$variable" '%s' "${answer:-$default}"
}

# Expand a prompted ~/ path and require a readable, nonempty regular file.
resolve_file() {
    local variable=$1
    local value=${!1}

    if [[ "$value" == '~/'* ]]; then
        value="$HOME/${value:2}"
    fi

    if [[ -z "$value" || ! -f "$value" || ! -r "$value" || ! -s "$value" ]]; then
        die "Unreadable, missing or empty file: $value"
    fi

    printf -v "$variable" '%s' "$(realpath -- "$value")"
}

# Delete only the private packaging directory created inside this project.
cleanup() {
    if [[ -n "${STAGE:-}" && "$STAGE" == "$PROJECT_ROOT"/.ptlnx-sd.* ]]; then
        rm -rf -- "$STAGE"
    fi
}

# =============================================================================
# Arguments and workflow state
# =============================================================================
PROJECT_NAME=
PROJECT_ROOT=
SDT_DIR=
BSP_FILE=
CFG_DIR=
CFG_PROJECT=
CFG_ROOTFS=
CFG_KERNEL=
BITSTREAM=
BITSTREAM_NAME=
BINARY=
BINARY_NAME=
STAGE=
EXPORT=
ROOTFS=
STARTUP_CREATED=false
SETTINGS=/opt/petalinux/2025.1/settings.sh
SSTATE_URL=https://edf.amd.com/sswreleases/rel-v2025.1/aarch64/sstate-cache
SCRIPT_DIR=$(dirname -- "$(realpath -- "${BASH_SOURCE[0]}")")

# Parse options before loading tools or creating any project files.
parse_arguments() {
    while (($#)); do
        case "$1" in
            -h|--h|--help)
                usage
                exit 0
                ;;
            -n|-sdt|-bsp|-cfg|--settings)
                if (($# < 2)) || [[ -z "$2" || "$2" == -* ]]; then
                    die "Missing value for $1"
                fi
                case "$1" in
                    -n) PROJECT_NAME=$2 ;;
                    -sdt) SDT_DIR=$2 ;;
                    -bsp) BSP_FILE=$2 ;;
                    -cfg) CFG_DIR=$2 ;;
                    --settings) SETTINGS=$2 ;;
                esac
                shift 2
                ;;
            *)
                die "Unknown option: $1. Use -h or --h for help."
                ;;
        esac
    done
}

# Validate inputs before starting the build.
validate_arguments() {
    if [[ -z "$PROJECT_NAME" || -z "$SDT_DIR" ]]; then
        usage
        die 'Both -n and -sdt are required.'
    fi
    if ! [[ "$PROJECT_NAME" =~ ^[A-Za-z0-9][A-Za-z0-9_.-]*$ ]]; then
        die 'Use a directory name, not a path, for -n.'
    fi
    if [[ -e "$PROJECT_NAME" || -L "$PROJECT_NAME" ]]; then
        die "Project already exists: $PROJECT_NAME. Choose a new project name."
    fi
    if [[ ! -d "$SDT_DIR" ]]; then
        die "SDT directory not found: $SDT_DIR"
    fi
    SDT_DIR=$(realpath -- "$SDT_DIR")
    case "$(realpath -m -- "$PROJECT_NAME")/" in
        "$SDT_DIR/"*)
            die 'Create the project outside the source SDT directory.'
            ;;
    esac

    # Resolve external paths before changing into the new project.
    if [[ -n "$CFG_DIR" ]]; then
        if [[ ! -d "$CFG_DIR" ]]; then
            die "Configuration directory not found: $CFG_DIR"
        fi
        CFG_DIR=$(realpath -- "$CFG_DIR")
        CFG_PROJECT=$(find_config config project-spec/configs/config no)
        CFG_ROOTFS=$(find_config rootfs_config project-spec/configs/rootfs_config no)
        CFG_KERNEL=$(find_config user.cfg project-spec/meta-user/recipes-kernel/linux/linux-xlnx/user.cfg no)
        if [[ ( -z "$CFG_PROJECT" || -z "$CFG_ROOTFS" || -z "$CFG_KERNEL" ) && ( ! -t 0 || ! -t 1 ) ]]; then
            die 'Missing configuration files require interactive menus. Run in a terminal or supply config, rootfs_config and user.cfg.'
        fi
    else
        if [[ ! -t 0 || ! -t 1 ]]; then
            die 'Run in an interactive terminal, or supply -cfg DIR with config, rootfs_config and user.cfg.'
        fi
    fi
}

# Select a board BSP automatically when there is exactly one beside the script.
select_board_bsp() {
    # Resolve the board BSP before creating any project directory.
    # Search only beside this script; never pick an arbitrary BSP from subfolders.
    if [[ -z "$BSP_FILE" ]]; then
        mapfile -d '' -t bsp_files < <(
            find "$SCRIPT_DIR" -maxdepth 1 -iname '*.bsp' \( -type f -o -type l \) -print0 | sort -z
        )
        case ${#bsp_files[@]} in
            0)
                info "No .bsp file found beside the script: $SCRIPT_DIR"
                if [[ ! -t 0 ]]; then
                    die 'BSP selection requires a terminal. Supply -bsp FILE.'
                fi
                if ! read -r -p 'Enter the path to the PetaLinux 2025.1 SDT BSP: ' BSP_FILE; then
                    die 'BSP input cancelled.'
                fi
                BSP_FILE=${BSP_FILE%$'\r'}
                if [[ -z "$BSP_FILE" ]]; then
                    die 'No BSP path provided.'
                fi
                # Accept ~/ paths without evaluating shell expressions from input.
                if [[ "$BSP_FILE" == '~/'* ]]; then
                    BSP_FILE="$HOME/${BSP_FILE:2}"
                fi
                ;;
            1)
                BSP_FILE=${bsp_files[0]}
                ;;
            *)
                info "Multiple BSP files found in $SCRIPT_DIR:"
                for index in "${!bsp_files[@]}"; do
                    printf '  %d) %s\n' "$((index + 1))" "${bsp_files[index]##*/}"
                done
                if [[ ! -t 0 ]]; then
                    die 'Multiple BSP files found. Supply -bsp FILE.'
                fi
                if ! read -r -p 'Select the BSP number: ' selection; then
                    die 'BSP selection cancelled.'
                fi
                selection=${selection%$'\r'}
                selected=
                for index in "${!bsp_files[@]}"; do
                    if [[ "$selection" == "$((index + 1))" ]]; then
                        selected=${bsp_files[index]}
                        break
                    fi
                done
                if [[ -z "$selected" ]]; then
                    die 'Invalid BSP selection.'
                fi
                BSP_FILE=$selected
                ;;
        esac
    fi
    if ! [[ "${BSP_FILE,,}" == *.bsp ]]; then
        die 'The BSP must have a .bsp extension.'
    fi
    if ! [[ -f "$BSP_FILE" && -r "$BSP_FILE" && -s "$BSP_FILE" ]]; then
        die "BSP not found, unreadable or empty: $BSP_FILE"
    fi
    BSP_FILE=$(realpath -- "$BSP_FILE")
    ok "Selected BSP: $BSP_FILE"
}

# Preserve explicit relative paths before changing the working directory.
resolve_argument_paths() {
    local variable
    for variable in SETTINGS; do
        if [[ -n "${!variable}" ]]; then
            resolve_file "$variable"
        fi
    done
}

# Resolve and validate the supplied script before entering the project.
# Syntax checking does not execute the user's code on the build host.
configure_startup_app() {
    section 'Generating automatic FPGA, overlay and driver startup'
    local module=${BOOT_DRIVER_NAME:-} appdir="$PROJECT_ROOT/project-spec/meta-user/recipes-apps/startupbash"
    if [[ -z "$module" ]]; then
        module="$(printf '%s' "${PROJECT_ROOT##*/}" | LC_ALL=C tr -cd 'A-Za-z0-9')Driver"
    fi
    module=${module,,}
    local overlay="$PROJECT_ROOT/${PROJECT_ROOT##*/}_wrapper/fpga/pl.dtbo"
    local ko="$PROJECT_ROOT/images/linux/$module.ko"
    [[ -s "$overlay" && -s "$ko" && -s "$BINARY" ]] || die 'Missing startup bitstream, overlay or compiled module.'
    [[ ! -L "$appdir" && ! -L "$appdir/files" ]] || die 'Refusing a symlinked startup recipe.'
    if [[ ! -d "$appdir" ]]; then
        petalinux-create apps --template install --name startupbash --enable
    fi
    mkdir -p "$appdir/files"
    local target
    for target in startupbash startupbash.service design.bin pl.dtbo driver.ko; do
        [[ ! -L "$appdir/files/$target" ]] || die "Refusing a symlinked startup file: $target"
    done
    [[ ! -L "$appdir/startupbash.bb" ]] || die 'Refusing a symlinked startup recipe file.'
    install -m 0644 "$BINARY" "$appdir/files/design.bin"
    install -m 0644 "$overlay" "$appdir/files/pl.dtbo"
    install -m 0644 "$ko" "$appdir/files/driver.ko"
    cat > "$appdir/files/startupbash" <<'AUTO_STARTUP'
#!/usr/bin/env bash
# Generated by create_ptlnx_all.sh; run once at boot through startupbash.service.
set -Eeuo pipefail
trap 'rc=$?; printf "[ERROR] KR260 startup failed at line %s (status %s).\n" "$LINENO" "$rc" >&2; exit "$rc"' ERR
info() { printf '[INFO] %s\n' "$*"; }
die() { printf '[ERROR] %s\n' "$*" >&2; exit 1; }
(( EUID == 0 )) || die 'Run as root.'
DATA_DIR=@DATA_DIR@
BITSTREAM=@FIRMWARE_FILE@
MODULE=@MODULE@
for tool in fpgautil mount mountpoint insmod; do
    command -v "$tool" >/dev/null || die "Missing tool: $tool"
done
for file in "$BITSTREAM" "$DATA_DIR/pl.dtbo" "$DATA_DIR/driver.ko"; do
    [[ -r "$file" && -s "$file" ]] || die "Missing or empty file: $file"
done
[[ -r /sys/class/fpga_manager/fpga0/state ]] || die 'FPGA Manager is unavailable.'
[[ ! -d "/sys/module/${MODULE//-/_}" ]] || die 'Driver is already loaded; refusing to reprogram active hardware.'
[[ -d /sys/kernel/config ]] || die 'Kernel configfs support is unavailable.'
if ! mountpoint -q /sys/kernel/config; then
    mount -t configfs configfs /sys/kernel/config
fi
OVERLAY=/sys/kernel/config/device-tree/overlays/kr260-startup
[[ -d /sys/kernel/config/device-tree/overlays ]] || die 'Kernel overlay configfs support is unavailable.'
[[ ! -e "$OVERLAY" ]] || die 'Startup overlay already exists; refusing to reprogram active hardware.'
info "Programming FPGA: $BITSTREAM"
fpgautil -b "$BITSTREAM"
read -r state < /sys/class/fpga_manager/fpga0/state
[[ "$state" == operating ]] || die "Unexpected FPGA Manager state: $state"
info 'FPGA programmed. Applying PL overlay.'
mkdir "$OVERLAY"
if ! cat "$DATA_DIR/pl.dtbo" > "$OVERLAY/dtbo"; then
    rmdir "$OVERLAY" || true
    die 'Overlay application failed; driver was not loaded.'
fi
if [[ -r "$OVERLAY/status" ]]; then
    read -r status < "$OVERLAY/status"
    [[ "$status" == applied ]] || die "Overlay status: $status"
fi
info "Overlay applied. Loading driver: $MODULE"
insmod "$DATA_DIR/driver.ko"
printf '[OK] FPGA, overlay and driver initialization completed.\n'
AUTO_STARTUP
    sed -i "s|@MODULE@|$module|g" "$appdir/files/startupbash"
    chmod +x "$appdir/files/startupbash"
    cat > "$appdir/files/startupbash.service" <<'SERVICE'
[Unit]
Description=KR260 FPGA programming, PL overlay and driver initialization
After=local-fs.target systemd-udev-trigger.service
Before=multi-user.target

[Service]
Type=oneshot
User=root
WorkingDirectory=/
ExecStart=/bin/bash /usr/bin/startupbash
RemainAfterExit=yes
TimeoutStartSec=180
StandardOutput=journal+console
StandardError=journal+console

[Install]
WantedBy=multi-user.target
SERVICE
    cat > "$appdir/startupbash.bb" <<'RECIPE'
SUMMARY = "Automatic KR260 FPGA, overlay and driver initialization"
LICENSE = "CLOSED"
SRC_URI = "file://startupbash file://startupbash.service file://design.bin file://pl.dtbo file://driver.ko"
S = "${WORKDIR}"
inherit systemd features_check
REQUIRED_DISTRO_FEATURES = "systemd"
RDEPENDS:${PN} += "bash fpga-manager-script kmod util-linux-mount util-linux-mountpoint"
PACKAGE_ARCH = "${MACHINE_ARCH}"
SYSTEMD_SERVICE:${PN} = "startupbash.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"
# The separately built module is deliberately copied without stripping/signature changes.
INHIBIT_PACKAGE_STRIP = "1"
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
do_install() {
    install -d ${D}${bindir} ${D}${systemd_system_unitdir} ${D}${datadir}/kr260-startup ${D}${nonarch_base_libdir}/firmware/kr260-startup
    install -m 0755 ${WORKDIR}/startupbash ${D}${bindir}/startupbash
    sed -i -e 's|@DATA_DIR@|${datadir}/kr260-startup|g' -e 's|@FIRMWARE_FILE@|${nonarch_base_libdir}/firmware/kr260-startup/design.bin|g' ${D}${bindir}/startupbash
    install -m 0644 ${WORKDIR}/startupbash.service ${D}${systemd_system_unitdir}/startupbash.service
    install -m 0644 ${WORKDIR}/design.bin ${D}${nonarch_base_libdir}/firmware/kr260-startup/design.bin
    install -m 0644 ${WORKDIR}/pl.dtbo ${WORKDIR}/driver.ko ${D}${datadir}/kr260-startup/
}
FILES:${PN} += "${systemd_system_unitdir}/startupbash.service ${datadir}/kr260-startup ${nonarch_base_libdir}/firmware/kr260-startup"
RECIPE
    STARTUP_CREATED=true
    ensure_startup_selected
    ok 'Generated automatic startup service: FPGA -> overlay -> driver.'
}

# Preserve the explicitly requested app selection after rootfs menu changes.
ensure_startup_selected() {
    [[ "$STARTUP_CREATED" == true ]] || return 0
    local config="$PROJECT_ROOT/project-spec/configs/rootfs_config"
    [[ -f "$config" ]] || die "Missing rootfs configuration: $config"
    sed -i '/^CONFIG_startupbash=/d; /^# CONFIG_startupbash is not set$/d' "$config"
    printf '%s\n' 'CONFIG_startupbash=y' >> "$config"
    petalinux-config -c rootfs --silentconfig
    grep -qx 'CONFIG_startupbash=y' "$config" ||
        die 'startupbash was not enabled in the rootfs configuration.'
    if grep -Eq '^CONFIG_init-manager-sysvinit=y$' "$config"; then
        die 'startupbash requires systemd. Select Image Features -> Init-manager -> systemd in petalinux-config -c rootfs.'
    fi
}

# Locate the original FPGA files without converting or renaming them.
# Check both inputs before the builds to catch missing or ambiguous files early.
select_fpga_files() {
    local -a bitstreams=()
    local -a binaries=()
    mapfile -d '' -t bitstreams < <(find "$SDT_DIR" -type f -iname '*.bit' -print0)
    if ((${#bitstreams[@]} != 1)); then
        die "Expected one .bit file in the SDT directory tree; found ${#bitstreams[@]}."
    fi
    BITSTREAM=${bitstreams[0]}
    resolve_file BITSTREAM
    BITSTREAM_NAME=${BITSTREAM##*/}
    if ! [[ "$BITSTREAM_NAME" =~ ^[A-Za-z0-9][A-Za-z0-9_.-]*$ ]]; then
        die 'Use a .bit filename containing only letters, digits, dots, underscores and hyphens.'
    fi
    ok "SD boot partition bitstream: $BITSTREAM_NAME"

    mapfile -d '' -t binaries < <(find "$SDT_DIR" -type f -iname '*.bin' -print0)
    if ((${#binaries[@]} != 1)); then
        die "Expected one .bin file in the SDT directory tree; found ${#binaries[@]}."
    fi
    BINARY=${binaries[0]}
    resolve_file BINARY
    BINARY_NAME=${BINARY##*/}
    if ! [[ "$BINARY_NAME" =~ ^[A-Za-z0-9][A-Za-z0-9_.-]*$ ]] || [[ "${BINARY_NAME,,}" == boot.bin ]]; then
        die 'Use a PL .bin filename containing only letters, digits, dots, underscores and hyphens; BOOT.BIN is reserved for boot firmware.'
    fi
    ok "FPGA binary for the SD boot partition and wrapper: $BINARY_NAME"
}

# =============================================================================
# PetaLinux configuration and system builds
# =============================================================================

load_petalinux_environment() {
    # Load the vendor environment without passing this script's CLI arguments.
    # Vendor setup can use unset variables; temporarily disable strict options
    # and the ERR trap, then restore them and check the setup result explicitly.
    resolve_file SETTINGS
    set --
    trap - ERR
    set +e +u
    set +o pipefail
    source "$SETTINGS"
    setup_status=$?
    set -Eeuo pipefail
    trap 'on_error "$?" "$LINENO"' ERR
    if ((setup_status != 0)); then
        die "PetaLinux settings.sh failed (exit status $setup_status)."
    fi
    for tool in petalinux-create petalinux-config petalinux-build petalinux-package; do
        if ! command -v "$tool" >/dev/null; then
            die "Command not found after setup: $tool"
        fi
    done
    if [[ -z "${PETALINUX:-}" ]]; then
        die 'PETALINUX is not set after loading settings.sh.'
    fi
    for tool in petalinux-create petalinux-config petalinux-build petalinux-package; do
        [[ "$(realpath "$(command -v "$tool")")" == "$(realpath "$PETALINUX")/"* ]] ||
            die "$tool does not belong to the loaded installation."
    done
    if ! tool_help=$(petalinux-create --help 2>&1); then
        die 'Cannot query PetaLinux tools.'
    fi
    if ! [[ "$tool_help" == *2025.1* || "$PETALINUX" == *2025.1* ]]; then
        die 'Cannot identify the installation as 2025.1.'
    fi
    ok 'PetaLinux 2025.1 environment loaded.'
}

# Persist the mirror in the project configuration, not in generated build files.
# Reapply before builds because imported settings or menu changes may replace it.
configure_sstate_mirror() {
    local config="$PROJECT_ROOT/project-spec/configs/config"
    local temporary

    if [[ ! -f "$config" || ! -r "$config" || ! -w "$config" ]]; then
        die "Cannot update the project configuration: $config"
    fi
    temporary=$(mktemp "${config}.sstate.XXXXXXXX")

    # Remove previous assignments and disabled entries, including duplicates.
    # Write one canonical value per option while retaining all other settings.
    if ! awk -v url="$SSTATE_URL" '
        /^(# )?CONFIG_YOCTO_(NETWORK_SSTATE_FEEDS(_URL)?|BB_NO_NETWORK)(=| is not set)/ { next }
        { print }
        END {
            print "CONFIG_YOCTO_NETWORK_SSTATE_FEEDS=y"
            print "CONFIG_YOCTO_NETWORK_SSTATE_FEEDS_URL=\"" url "\""
            print "# CONFIG_YOCTO_BB_NO_NETWORK is not set"
        }
    ' "$config" > "$temporary"; then
        rm -f -- "$temporary"
        die 'Could not prepare the network sstate configuration.'
    fi

    # Retain the existing file permissions rather than replacing it with mktemp.
    if ! cat -- "$temporary" > "$config"; then
        rm -f -- "$temporary"
        die "Could not save the project configuration: $config"
    fi
    rm -f -- "$temporary"
    ok "Network sstate mirror: $SSTATE_URL"
}

create_and_build_project() {
    # Create the project from the board BSP, preserving its board defaults.
    info "Creating project: $PROJECT_NAME"
    petalinux-create project --source "$BSP_FILE" --name "$PROJECT_NAME"
    cd -- "$PROJECT_NAME"
    PROJECT_ROOT=$(pwd -P)
    if [[ -n "$CFG_PROJECT" ]]; then
        import_config "$CFG_PROJECT" project-spec/configs/config
    fi
    if [[ -n "$CFG_KERNEL" ]]; then
        import_config "$CFG_KERNEL" project-spec/meta-user/recipes-kernel/linux/linux-xlnx/user.cfg
    fi

    # Show the selected mirror in the hardware import configuration menu too.
    configure_sstate_mirror

    # The project config file alone determines whether hardware import is silent.
    section "Importing SDT hardware"
    info "SDT directory: $SDT_DIR"
    if [[ -n "$CFG_PROJECT" ]]; then
        petalinux-config --get-hw-description "$SDT_DIR" --silentconfig
    else
        petalinux-config --get-hw-description "$SDT_DIR"
    fi
    if [[ -n "$CFG_ROOTFS" ]]; then
        import_config "$CFG_ROOTFS" project-spec/configs/rootfs_config
    fi

    configure_kernel

    # Build after saving the project configuration.
    section 'Building project (1/2)'
    configure_sstate_mirror
    petalinux-build
    ok 'First build completed.'
}

# Apply a saved fragment, or let the user configure the kernel interactively.
configure_kernel() {
    local fragment="$PROJECT_ROOT/project-spec/meta-user/recipes-kernel/linux/linux-xlnx/user.cfg"
    local append="$PROJECT_ROOT/project-spec/meta-user/recipes-kernel/linux/linux-xlnx_%.bbappend"
    local silent=false
    if [[ -n "$CFG_KERNEL" ]]; then
        silent=true
    fi
    section 'Configuring the Linux kernel'
    if [[ "$silent" == true ]]; then
        [[ -r "$fragment" && -s "$fragment" ]] || die "Missing kernel fragment: $fragment"
        # Make the imported fragment visible to the kernel recipe. Preserve
        # existing BSP customizations and add our declarations only once.
        if [[ ! -f "$append" ]] || ! grep -Fqx '# create_ptlnx_prj: kernel fragment' "$append"; then
            cat >> "$append" <<'KERNEL_APPEND'

# create_ptlnx_prj: kernel fragment
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI:append = " file://user.cfg"
KERNEL_APPEND
        fi
        info "Using kernel fragment: $fragment"
        petalinux-config -c kernel --silentconfig
    else
        [[ -t 0 && -t 1 ]] || die 'Kernel menu requires an interactive terminal.'
        petalinux-config -c kernel
    fi
    ok 'Kernel configuration completed.'
}

configure_rootfs() {
    # Configure rootfs using the imported values or the interactive menu.
    info 'Configuring rootfs'
    if [[ -n "$CFG_ROOTFS" ]]; then
        petalinux-config -c rootfs --silentconfig
    else
        petalinux-config -c rootfs
    fi
}

# Rebuild the complete system after saving the rootfs menu.
build_system() {
    ensure_startup_selected
    section 'Building project (2/2)'
    configure_sstate_mirror
    petalinux-build
    ok 'Second build completed.'
}

# =============================================================================
# SD image packaging
# =============================================================================

# Stage the boot image so a stale BOOT.BIN cannot mask a packaging failure.
package_boot_image() {
    local images="$PROJECT_ROOT/images/linux"
    local output="$STAGE/BOOT.BIN"
    local component

    section 'Preparing BOOT.BIN'
    for component in zynqmp_fsbl.elf pmufw.elf bl31.elf u-boot.elf; do
        [[ -r "$images/$component" && -s "$images/$component" ]] ||
            die "Missing boot component: $images/$component. Enable/build this component before packaging."
    done
    petalinux-package boot --format BIN \
        --fsbl "$images/zynqmp_fsbl.elf" \
        --pmufw "$images/pmufw.elf" \
        --atf "$images/bl31.elf" \
        --u-boot "$images/u-boot.elf" \
        --output "$output"
    [[ -r "$output" && -s "$output" ]] || die 'A new BOOT.BIN was not produced.'
    # Replace the directory entry, not a possible symlink into Yocto deploy files.
    mv -f -- "$output" "$images/BOOT.BIN"
    mkdir -p "$EXPORT"
    ok "Boot image ready: $images/BOOT.BIN"
}

package_sd_image() {
    IMAGES_DIR="$PROJECT_ROOT/images/linux"
    local name
    local wic_outdir="$STAGE/wic-output"
    local initrd_found=false
    local initrd_selected=false
    local bootfiles_csv
    local -a bootfiles=(BOOT.BIN boot.scr Image system.dtb)
    local -a wic_args=()

    # The rootfs archive populates the root filesystem partition. It is not
    # itself a boot partition file and is separate from any INITRD archive.
    if ! [[ -r "$ROOTFS" && -s "$ROOTFS" ]]; then
        die 'Missing rootfs.tar.gz. Enable this output in Image Packaging Configuration.'
    fi
    if ! [[ -r "$IMAGES_DIR/BOOT.BIN" && -s "$IMAGES_DIR/BOOT.BIN" ]]; then
        die 'Missing BOOT.BIN after boot image packaging.'
    fi
    for name in "${bootfiles[@]}"; do
        if ! [[ -r "$IMAGES_DIR/$name" && -s "$IMAGES_DIR/$name" ]]; then
            die "Missing SD boot file: $name"
        fi
    done

    info 'Creating the Linux SD image using the existing board QSPI firmware.'

    # Copy the original SDT bitstream as a plain file. This does not configure
    # the FPGA during boot and does not add a bitstream partition to BOOT.BIN.
    if ! [[ -r "$BITSTREAM" && -s "$BITSTREAM" ]]; then
        die "Unreadable or empty bitstream: $BITSTREAM"
    fi
    if [[ ! "$BITSTREAM" -ef "$IMAGES_DIR/$BITSTREAM_NAME" ]]; then
        cp -- "$BITSTREAM" "$IMAGES_DIR/$BITSTREAM_NAME"
    fi
    bootfiles+=("$BITSTREAM_NAME")

    # Include the original PL binary for runtime programming with fpgautil.
    [[ -r "$BINARY" && -s "$BINARY" ]] || die "Unreadable or empty PL binary: $BINARY"
    if [[ ! "$BINARY" -ef "$IMAGES_DIR/$BINARY_NAME" ]]; then
        cp -- "$BINARY" "$IMAGES_DIR/$BINARY_NAME"
    fi
    bootfiles+=("$BINARY_NAME")

    # Older notes use INITRD. Preserve that user-selected mode without forcing
    # it on the 2025.1 persistent-rootfs layout or copying every old image.
    if grep -Eq '^CONFIG_SUBSYSTEM_ROOTFS_INITRD=y[[:space:]]*$' project-spec/configs/config; then
        initrd_selected=true
    fi
    if [[ "$initrd_selected" == true ]]; then
        for name in rootfs.cpio.gz.u-boot ramdisk.cpio.gz.u-boot ramdisk.cpio.gz rootfs.cpio.gz; do
            if [[ -r "$IMAGES_DIR/$name" && -s "$IMAGES_DIR/$name" ]]; then
                if [[ ! " ${bootfiles[*]} " == *" $name "* ]]; then
                    bootfiles+=("$name")
                fi
                initrd_found=true
            fi
        done
        if [[ "$initrd_found" == false ]]; then
            die 'INITRD is selected but no standard ramdisk was generated. Enable and build a standard INITRD image before packaging.'
        fi
    fi

    info 'Using the PetaLinux default partition layout.'

    # A private output directory prevents an old WIC from being exported if a
    # packager invocation returns without producing the expected new image.
    mkdir -p "$wic_outdir"
    bootfiles_csv=$(IFS=,; printf '%s' "${bootfiles[*]}")
    wic_args=(
        wic
        --images-dir "$IMAGES_DIR"
        --rootfs-file "$ROOTFS"
        --bootfiles "$bootfiles_csv"
        --outdir "$wic_outdir"
    )
    section 'Packaging the SD WIC image'
    info "Boot partition files: $bootfiles_csv"
    petalinux-package "${wic_args[@]}"
    if ! [[ -s "$wic_outdir/petalinux-sdimage.wic" ]]; then
        die 'A new petalinux-sdimage.wic was not generated.'
    fi
    mv -- "$wic_outdir/petalinux-sdimage.wic" "$IMAGES_DIR/petalinux-sdimage.wic"
    mkdir -p "$EXPORT"
    cp -- "$IMAGES_DIR/petalinux-sdimage.wic" "$EXPORT/"
    ok "SD image ready: $IMAGES_DIR/petalinux-sdimage.wic"
}

# Copy the original FPGA files from SDT into the completed project wrapper.
export_fpga_files() {
    local source
    local destination

    [[ ! -L "$EXPORT/fpga" ]] || die "Refusing a symlinked FPGA output directory."
    mkdir -p "$EXPORT/fpga"
    for source in "$BITSTREAM" "$BINARY"; do
        if [[ ! -f "$source" || ! -r "$source" || ! -s "$source" ]]; then
            die "FPGA input is no longer readable or is empty: $source"
        fi
        destination="$EXPORT/fpga/${source##*/}"
        if [[ ! "$source" -ef "$destination" ]]; then
            cp -- "$source" "$destination"
        fi
        ok "FPGA file copied to wrapper: $destination"
    done
}

# Keep the requested configuration/build order explicit.
main() {
    parse_arguments "$@"
    trap cleanup EXIT

    section 'Checking inputs'
    validate_arguments
    resolve_argument_paths
    select_fpga_files

    section 'Selecting the board BSP'
    select_board_bsp

    section 'Loading PetaLinux 2025.1'
    load_petalinux_environment

    section 'Creating the project'
    create_and_build_project

    section 'Configuring rootfs'
    configure_rootfs
    section 'Generating and compiling the driver'
    run_embedded_driver
    configure_startup_app

    build_system

    # Isolate new packaging output so a previous WIC cannot mask a failure.
    ROOTFS="$PROJECT_ROOT/images/linux/rootfs.tar.gz"
    EXPORT="$PROJECT_ROOT/${PROJECT_NAME}_wrapper"
    STAGE=$(mktemp -d "$PROJECT_ROOT/.ptlnx-sd.XXXXXXXX")
    trap cleanup EXIT
    package_boot_image
    package_sd_image

    section 'Copying FPGA files to the wrapper'
    export_fpga_files

    cd -- "$PROJECT_ROOT"

    section 'Completed'
    ok "WIC copy: $EXPORT/petalinux-sdimage.wic"
    ok "Project directory: $PWD"
    info 'To enter this directory in your calling terminal, run:'
    printf '  cd -- %q\n' "$PROJECT_ROOT"
    if [[ "$STARTUP_CREATED" == true ]]; then
        ok 'Startup app included: /usr/bin/startupbash (startupbash.service).'
        info 'On the board: journalctl -u startupbash.service -b'
    fi
}


BOOT_DRIVER_NAME=
DRIVER_ARGS=()
PROJECT_ARGS=()
parse_combined_arguments() {
    while (($#)); do
        case "$1" in
            --force-driver) DRIVER_ARGS+=(--force); shift ;;
            --driver-name|-gen)
                (($# >= 2)) || die "Missing argument after $1"
                [[ -n "$2" && "$2" != -* ]] || die "Missing argument after $1"
                if [[ "$1" == -gen ]]; then
                    DRIVER_ARGS+=(-gen "$(realpath -m -- "$2")")
                else
                    BOOT_DRIVER_NAME=$2
                    DRIVER_ARGS+=(-n "$2")
                fi
                shift 2 ;;
            *) PROJECT_ARGS+=("$1"); shift ;;
        esac
    done
}

run_embedded_driver() (
    cd -- "$PROJECT_ROOT"
    local_driver=$(mktemp "$PROJECT_ROOT/.embedded-driver.XXXXXXXX.sh")
    trap 'rm -f -- "$local_driver"' EXIT
    cat > "$local_driver" <<'EMBEDDED_DRIVER_EOF'
#!/usr/bin/env bash
# Create and build a PetaLinux 2025.1 driver from project-spec/configs/pl.dtsi.
# See --help for input requirements and wrapper layout.
set -Eeuo pipefail

log() {
    local level=$1 color=$2 stream=$3
    shift 3
    if [[ -t "$stream" && "${TERM:-dumb}" != dumb && -z "${NO_COLOR+x}" ]]; then
        printf '\033[%sm[%s] %s\033[0m\n' "$color" "$level" "$*" >&"$stream"
    else
        printf '[%s] %s\n' "$level" "$*" >&"$stream"
    fi
}
info() { log INFO 36 1 "$@"; }
ok() { log OK 32 1 "$@"; }
error() { log ERROR 31 2 "$@"; }
section() {
    printf '\n'
    info "========== $* =========="
    printf '\n'
}
die() { error "$*"; exit 1; }
on_error() {
    local status=$1 line=$2
    error "Command failed at line $line (exit status $status)."
    exit "$status"
}
trap 'on_error "$?" "$LINENO"' ERR

usage() {
    cat <<'HELP'
Usage: ./create_ptlnx_driver.sh [-gen DIR] [-n NAME] [-f|--force]
Run from the PetaLinux project root. Input: project-spec/configs/pl.dtsi.
-gen DIR: generator directory (default /opt/petalinux/docs/driver_generation).
-n NAME: module name; default is the sanitized project name plus Driver.
-f, --force: replace existing generated outputs and rebuild the module.
-h, --help: show this help.
The generator directory must contain one .py, one .c.template and one .h.template.
Driver sources are exported to <project>_wrapper/code/.
The wrapper fpga/ directory holds .ko, PL .bin/.bit, program_fpga.sh, pl.dtsi
and pl.dtbo. Existing root-level PL bitstreams are moved there, excluding BOOT.BIN.
A copy of the project pl.dtsi is corrected with #address-cells = <2> and
#size-cells = <2> inside &amba, then compiled with dtc -@. The original is preserved.
Remove firmware-name from the wrapper overlay so it uses the bitstream already
loaded at boot. That bitstream must match the overlay and driver.
Conflicting existing cell values stop the script. dtc must be available in PATH.
HELP
}

GEN_DIR=/opt/petalinux/docs/driver_generation
GEN_OPTION_SET=false
GENERATOR=
C_TEMPLATE=
H_TEMPLATE=
MODULE_NAME=
FORCE=false
PROJECT_ROOT=
MODULE_ID=
RECIPE_NAME=
PL_DTS=
SYNCH_FIFO=
WORK_DIR=
WRAPPER_DIR=
PL_DTBO=

cleanup() {
    if [[ -n "$WORK_DIR" && "$WORK_DIR" == "$PROJECT_ROOT"/.driver-generation.* ]]; then
        rm -rf -- "$WORK_DIR"
    fi
}

parse_arguments() {
    while (($#)); do
        case "$1" in
            -h|--help) usage; exit 0 ;;
            -f|--force) FORCE=true; shift ;;
            -n)
                (($# >= 2)) || die 'Missing module name after -n.'
                [[ -n "$2" && "$2" != -* ]] || die 'Missing module name after -n.'
                [[ -z "$MODULE_NAME" ]] || die 'Specify -n only once.'
                MODULE_NAME=$2
                shift 2
                ;;
            -gen)
                (($# >= 2)) || die 'Missing directory after -gen.'
                [[ -n "$2" && "$2" != -* ]] || die 'Missing directory after -gen.'
                [[ "$GEN_OPTION_SET" == false ]] || die 'Specify -gen only once.'
                GEN_DIR=$2
                GEN_OPTION_SET=true
                shift 2
                ;;
            *) die "Unknown option: $1. Use --help for usage." ;;
        esac
    done
}

select_module_name() {
    local project_name base
    if [[ -z "$MODULE_NAME" ]]; then
        project_name=${PWD##*/}
        base=$(printf '%s' "$project_name" | LC_ALL=C tr -cd 'A-Za-z0-9')
        [[ -n "$base" ]] || die 'The directory name contains no letters or digits. Supply -n NAME.'
        MODULE_NAME="${base}Driver"
        info "Module name derived from project directory: $project_name"
    fi
    # The generator substitutes this name into C identifiers.
    [[ "$MODULE_NAME" =~ ^[A-Za-z_][A-Za-z0-9_]*$ ]] ||
        die "Invalid C module identifier: $MODULE_NAME. Supply -n NAME starting with a letter or underscore and using only letters, digits and underscores."
    ok "Module name: $MODULE_NAME"
}

require_file() {
    local path=$1
    [[ -f "$path" && -r "$path" && -s "$path" ]] ||
        { error "Missing, unreadable or empty file: $path"; return 1; }
}

validate_generator_directory() {
    local candidate pattern label selected resolved
    local -a matches=()
    GENERATOR=
    C_TEMPLATE=
    H_TEMPLATE=
    info 'Checking the generator directory.'
    if [[ "$GEN_DIR" == '~/'* ]]; then
        GEN_DIR="$HOME/${GEN_DIR:2}"
    fi
    [[ -d "$GEN_DIR" && -r "$GEN_DIR" && -x "$GEN_DIR" ]] ||
        { error "Directory does not exist or is inaccessible: $GEN_DIR"; return 1; }
    resolved=$(cd -- "$GEN_DIR" && pwd -P) || return 1
    GEN_DIR=$resolved

    for pattern in '*.py' '*.c.template' '*.h.template'; do
        matches=()
        # Scan literal directory entries; patterns only match the basename.
        for candidate in "$GEN_DIR"/* "$GEN_DIR"/.[!.]* "$GEN_DIR"/..?*; do
            [[ -f "$candidate" ]] || continue
            [[ "${candidate##*/}" == $pattern ]] || continue
            matches+=("$candidate")
        done
        if ((${#matches[@]} != 1)); then
            error "Expected exactly one $pattern file in $GEN_DIR; found ${#matches[@]}."
            if ((${#matches[@]} > 1)); then
                printf '  %s\n' "${matches[@]}" >&2
            fi
            return 1
        fi
        selected=${matches[0]}
        require_file "$selected" || return 1
        case "$pattern" in
            '*.py') GENERATOR=$selected ;;
            '*.c.template') C_TEMPLATE=$selected ;;
            '*.h.template') H_TEMPLATE=$selected ;;
        esac
    done
    ok "Generator directory: $GEN_DIR"
    ok "Python generator: $GENERATOR"
    ok "C template: $C_TEMPLATE"
    ok "Header template: $H_TEMPLATE"
    ok 'Input validation completed.'
}

prepare_project() {
    PROJECT_ROOT=$(pwd -P)
    [[ -s "$PROJECT_ROOT/project-spec/configs/config" && -d "$PROJECT_ROOT/project-spec/meta-user" ]] ||
        die 'Run this script from the PetaLinux project root.'
    command -v python3 >/dev/null || die 'python3 is required.'
    if ! command -v petalinux-create >/dev/null || ! command -v petalinux-build >/dev/null; then
        local settings=/opt/petalinux/2025.1/settings.sh status
        [[ -r "$settings" ]] || die "Load PetaLinux 2025.1 settings before running this script: $settings"
        info "Loading PetaLinux settings: $settings"
        trap - ERR
        set +e +u
        set +o pipefail
        source "$settings"
        status=$?
        set -Eeuo pipefail
        trap 'on_error "$?" "$LINENO"' ERR
        (( status == 0 )) || die 'PetaLinux environment setup failed.'
    fi
    for tool in petalinux-create petalinux-build; do
        command -v "$tool" >/dev/null || die "Missing tool: $tool"
    done
    local help_text
    help_text=$(petalinux-create --help 2>&1) || die 'Cannot query PetaLinux version.'
    [[ "$help_text" == *2025.1* || "${PETALINUX:-}" == *2025.1* ]] ||
        die 'Load the PetaLinux 2025.1 environment for this project.'
    MODULE_ID=${MODULE_NAME,,}
    RECIPE_NAME=${MODULE_ID//_/-}
    [[ "$RECIPE_NAME" =~ ^[a-z][a-z0-9-]*$ ]] ||
        die 'For PetaLinux recipes, use a module name starting with a letter.'
    local appdir="$PROJECT_ROOT/project-spec/meta-user/recipes-modules/$RECIPE_NAME"
    [[ ! -L "$appdir" ]] || die "Module directory must not be a symlink: $appdir"
    if [[ -e "$appdir" ]]; then
        [[ -d "$appdir" ]] || die "Module path is not a directory: $appdir"
        [[ "$FORCE" == true ]] || die "Module recipe already exists: $appdir. Use -f or --force to overwrite."
    fi
    WRAPPER_DIR="$PROJECT_ROOT/${PROJECT_ROOT##*/}_wrapper"
    [[ ! -L "$WRAPPER_DIR" ]] || die "Wrapper directory must not be a symlink: $WRAPPER_DIR"
    if [[ -e "$WRAPPER_DIR" && ! -d "$WRAPPER_DIR" ]]; then
        die "Wrapper path is not a directory: $WRAPPER_DIR"
    fi
    local subdir
    for subdir in "$WRAPPER_DIR/code" "$WRAPPER_DIR/fpga"; do
        [[ ! -L "$subdir" ]] || die "Wrapper subdirectory must not be a symlink: $subdir"
        [[ ! -e "$subdir" || -d "$subdir" ]] || die "Not a directory: $subdir"
    done
    local target
    for target in "$appdir/files" "$appdir/files/$MODULE_ID.c" \
        "$appdir/files/$MODULE_ID.h" "$appdir/files/Makefile" "$appdir/$RECIPE_NAME.bb" \
        "$WRAPPER_DIR/code/$MODULE_ID.c" "$WRAPPER_DIR/code/$MODULE_ID.h" \
        "$WRAPPER_DIR/fpga/$MODULE_ID.ko" "$WRAPPER_DIR/fpga/pl.dtbo" "$WRAPPER_DIR/fpga/program_fpga.sh"; do
        [[ ! -L "$target" ]] || die "Refusing to write through a symlink: $target"
    done
    if [[ "$FORCE" == false ]]; then
        for target in "$WRAPPER_DIR/code/$MODULE_ID.c" "$WRAPPER_DIR/code/$MODULE_ID.h" \
        "$WRAPPER_DIR/fpga/$MODULE_ID.ko" "$WRAPPER_DIR/fpga/pl.dtbo" "$WRAPPER_DIR/fpga/program_fpga.sh"; do
            [[ ! -e "$target" ]] || die "Final output already exists: $target. Use -f or --force to overwrite."
        done
    fi
    ok "Project: $PROJECT_ROOT"
    info "C module: $MODULE_ID; PetaLinux recipe: $RECIPE_NAME"
}

select_pl_description() {
    PL_DTS="$PROJECT_ROOT/project-spec/configs/pl.dtsi"
    require_file "$PL_DTS" || die 'Missing project-spec/configs/pl.dtsi. Configure the project first.'
    ok "Project PL source: $PL_DTS"
}

select_fifo() {
    local detected
    local -a fifos=()
    info "PL description for FIFO selection: $PL_DTS"
    # Match the labelled axi_fifo_mm_s nodes recognized by the supplied generator.
    detected=$(python3 - "$PL_DTS" <<'FIFO_PY'
import re
import sys
from pathlib import Path

text = Path(sys.argv[1]).read_text(encoding="utf-8")
nodes = re.compile(
    r"^\s*(?P<label>[a-zA-Z_][a-zA-Z0-9_-]*)\s*:\s*"
    r"(?P<node>[a-zA-Z_][a-zA-Z0-9,_-]*)"
    r"@[0-9a-fA-F]+\s*\{(?P<body>.*?)^\s*\};",
    re.MULTILINE | re.DOTALL,
)
labels = dict.fromkeys(
    node.group("label") for node in nodes.finditer(text)
    if node.group("node") == "axi_fifo_mm_s"
)
for label in labels:
    print(label)
FIFO_PY
    ) || die 'Could not read the PL description to detect FIFO labels.'
    if [[ -n "$detected" ]]; then
        mapfile -t fifos <<< "$detected"
    fi
    if ((${#fifos[@]} == 1)); then
        SYNCH_FIFO=${fifos[0]}
        ok "Single FIFO detected; selected automatically: $SYNCH_FIFO"
        return
    fi
    if ((${#fifos[@]} > 1)); then
        info 'Multiple FIFOs detected. Select the one to use as synchronous FIFO:'
        printf '  %s\n' "${fifos[@]}"
    else
        info 'No supported AXI FIFO MM-S detected. Enter a label manually or press Enter for none.'
    fi
    while true; do
        printf 'Synchronous FIFO label from pl.dtsi (Enter for none): ' >&2
        if ! IFS= read -r SYNCH_FIFO; then
            die 'Input ended before the FIFO selection was completed.'
        fi
        SYNCH_FIFO=${SYNCH_FIFO%$'\r'}
        if [[ -z "$SYNCH_FIFO" ]]; then
            info 'No synchronous FIFO selected; omitting the optional generator argument.'
            return
        fi
        if [[ "$SYNCH_FIFO" =~ ^[A-Za-z_][A-Za-z0-9_]*$ ]]; then
            ok "Synchronous FIFO label: $SYNCH_FIFO"
            info 'The generator will check that this label identifies a supported FIFO.'
            return
        fi
        error 'Enter a device-tree label (letters, digits and underscores), without & or an address.'
    done
}

generate_sources() {
    WORK_DIR=$(mktemp -d "$PROJECT_ROOT/.driver-generation.XXXXXXXX")
    mkdir -p "$WORK_DIR/tools" "$WORK_DIR/generated"
    # The supplied generator expects these template names beside its Python file.
    cp -- "$GENERATOR" "$WORK_DIR/tools/generate.py"
    cp -- "$C_TEMPLATE" "$WORK_DIR/tools/zynq_device.c.template"
    cp -- "$H_TEMPLATE" "$WORK_DIR/tools/zynq_device.h.template"
    info "Generating C sources for $MODULE_NAME"
    local -a generator_args=("$MODULE_NAME" "$PL_DTS")
    if [[ -n "$SYNCH_FIFO" ]]; then
        generator_args+=("$SYNCH_FIFO")
    fi
    (cd "$WORK_DIR/generated" && python3 "$WORK_DIR/tools/generate.py" "${generator_args[@]}")
    local file
    for file in "$MODULE_ID.c" "$MODULE_ID.h"; do
        require_file "$WORK_DIR/generated/$file" || die "Generator did not produce $file"
        if grep -nE '\$\$[A-Za-z_][A-Za-z0-9_]*\$\$' "$WORK_DIR/generated/$file"; then
            die "Unresolved template placeholders in $file"
        fi
    done
    ok 'Driver C source and header generated.'
}

configure_fsbl_domain() {
    section 'Configuring the FSBL and PMU firmware domains'
    local config="$PROJECT_ROOT/project-spec/configs/config"
    if ! grep -qx 'CONFIG_SYSTEM_ZYNQMP=y' "$config"; then
        info 'ZynqMP firmware domain fixes are not applicable; skipping.'
        return
    fi
    local machine domain dts confdir fix bsp temporary suffix processor option tag spec
    machine=$(sed -n 's/^CONFIG_YOCTO_MACHINE_NAME="\([^"]*\)"$/\1/p' "$config")
    [[ "$machine" =~ ^[A-Za-z0-9][A-Za-z0-9_.-]*$ ]] ||
        die 'Cannot determine a unique machine name from CONFIG_YOCTO_MACHINE_NAME.'
    confdir="$PROJECT_ROOT/project-spec/meta-user/conf"
    fix="$confdir/driver-fsbl-fix.conf"
    bsp="$confdir/petalinuxbsp.conf"
    [[ ! -L "$fix" && ! -L "$bsp" ]] || die 'Refusing to modify symlinked FSBL configuration files.'
    mkdir -p "$confdir"
    temporary="$WORK_DIR/driver-fsbl-fix.conf"
    cat > "$temporary" <<'FSBL_CONF'
# Managed by create_ptlnx_driver.sh. Recreated when the driver is built.
# Each processor/device-tree selection is scoped to its firmware multiconfig.
FSBL_CONF
    for spec in \
        'cortexa53-fsbl:psu_cortexa53_0:CONFIG_YOCTO_BBMC_CORTEXA53_FSBL:driver-fsbl-domain' \
        'microblaze-pmu:psu_pmu_0:CONFIG_YOCTO_BBMC_MICROBLAZE_PMU:driver-pmu-domain'; do
        IFS=: read -r suffix processor option tag <<< "$spec"
        grep -qx "$option=y" "$config" || continue
        domain="$machine-$suffix"
        dts="$PROJECT_ROOT/components/plnx_workspace/device-tree/$domain.dts"
        require_file "$dts" || die "Missing domain DTS for $suffix. Import/configure the project hardware first."
        cat > "$WORK_DIR/domain.conf" <<'DOMAIN_CONF'

OVERRIDES:append = "${@':@TAG@' if d.getVar('BB_CURRENT_MC') == '@DOMAIN@' else ''}"
ESW_MACHINE:@TAG@ = "@PROCESSOR@"
CONFIG_DTFILE:@TAG@ = "${TOPDIR}/../components/plnx_workspace/device-tree/@DOMAIN@.dts"
DOMAIN_CONF
        sed -e "s/@TAG@/$tag/g" -e "s/@DOMAIN@/$domain/g" \
            -e "s/@PROCESSOR@/$processor/g" "$WORK_DIR/domain.conf" >> "$temporary"
        ok "Firmware domain: $domain; processor: $processor"
        info "Domain device tree: $dts"
    done
    install -m 0644 "$temporary" "$fix"
    # Keep existing BSP settings, and include the managed fix only once.
    if [[ ! -f "$bsp" ]] || ! grep -Fqx 'require conf/driver-fsbl-fix.conf' "$bsp"; then
        printf '\n# Driver build: Cortex-A53 FSBL domain settings.\nrequire conf/driver-fsbl-fix.conf\n' >> "$bsp"
    fi
    info "Persistent configuration: $fix"
}

find_deployed_module() {
    local configured_tmp path candidate selected=
    local -a roots=("$PROJECT_ROOT/build")
    configured_tmp=$(sed -n 's/^CONFIG_TMP_DIR_LOCATION="\([^"]*\)"$/\1/p' "$PROJECT_ROOT/project-spec/configs/config")
    configured_tmp=${configured_tmp//\$\{PROOT\}/$PROJECT_ROOT}
    if [[ -n "$configured_tmp" && "$configured_tmp" != *'$'* ]]; then
        [[ "$configured_tmp" == /* ]] || configured_tmp="$PROJECT_ROOT/$configured_tmp"
        if [[ -d "$configured_tmp" && "$configured_tmp" != "$PROJECT_ROOT/build"/* && "$configured_tmp" != "$PROJECT_ROOT/build" ]]; then
            roots+=("$configured_tmp")
        fi
    fi
    for path in "${roots[@]}"; do
        [[ -d "$path" ]] || continue
        while IFS= read -r -d '' candidate; do
            [[ -r "$candidate" && -s "$candidate" ]] || continue
            if [[ -n "$selected" ]] && ! cmp -s -- "$selected" "$candidate"; then
                die "Different deployed modules found: $selected and $candidate. Resolve the ambiguity before export."
            fi
            selected=$candidate
        done < <(find "$path" -path '*/deploy/images/*' \
            \( -type f -o -type l \) -name "$MODULE_ID.ko" -print0)
    done
    [[ -n "$selected" ]] || return 1
    printf '%s' "$selected"
}

prepare_pl_overlay() {
    section 'Preparing the PL device-tree overlay'
    command -v dtc >/dev/null || die 'Install device-tree-compiler in the build container.'
    local directory="$WRAPPER_DIR/fpga" copy="$WRAPPER_DIR/fpga/pl.dtsi" target
    for target in "$WRAPPER_DIR" "$directory"; do
        [[ ! -L "$target" && ( ! -e "$target" || -d "$target" ) ]] || die "Invalid directory: $target"
    done
    for target in "$copy" "$directory/pl.dtbo"; do
        [[ ! -L "$target" && ( ! -e "$target" || -f "$target" ) ]] || die "Invalid output: $target"
        [[ ! -e "$target" || "$FORCE" == true ]] || die "Output exists: $target. Use -f."
    done
    mkdir -p "$directory"
    python3 - "$PL_DTS" "$copy" <<'FIX_PL' || die 'Could not correct the wrapper source.'
import re, sys
from pathlib import Path
text = Path(sys.argv[1]).read_text(encoding='utf-8-sig')
masked = re.sub(r'/\*.*?\*/|//[^\n]*|"(?:\\.|[^"\\])*"', lambda m: ' ' * len(m.group()), text, flags=re.S)
if not all(re.search(p, masked) for p in (r'/dts-v1/\s*;', r'/plugin/\s*;')):
    sys.exit('Expected a standalone PetaLinux overlay source.')
matches = list(re.finditer(r'&amba\s*\{', masked))
if len(matches) != 1: sys.exit('Expected exactly one &amba block.')
start = matches[0].end()
depth = 1
end = start
while end < len(masked) and depth:
    depth += (masked[end] == '{') - (masked[end] == '}')
    end += 1
if depth: sys.exit('Unclosed &amba block.')
body = list(masked[start:end-1]); depth = 0
for i, ch in enumerate(body):
    if ch == '{': depth += 1
    if depth: body[i] = ' '
    if ch == '}': depth -= 1
body = ''.join(body)
additions = []
for name in ('#address-cells', '#size-cells'):
    values = re.findall(re.escape(name) + r'\s*=\s*([^;]+);', body)
    if len(values) > 1 or (values and not re.fullmatch(r'<\s*(?:2|0x0*2)\s*>', values[0].strip())):
        sys.exit('Incompatible existing ' + name + ' in &amba.')
    if not values: additions.append('\n        ' + name + ' = <2>;')
text = text[:start] + ''.join(additions) + text[start:]
# Keep clock/AFI nodes, but do not ask FPGA Manager to reload firmware.
# Mask comments/strings to avoid altering commented examples or string contents.
masked = re.sub(r'/\*.*?\*/|//[^\n]*|"(?:\\.|[^"\\])*"', lambda m: ' ' * len(m.group()), text, flags=re.S)
properties = list(re.finditer(r'(?<![A-Za-z0-9_,.-])firmware-name\s*=\s*[^;]*;', masked))
for prop in reversed(properties):
    text = text[:prop.start()] + text[prop.end():]
Path(sys.argv[2]).write_text(text, encoding='utf-8', newline='\n')
print('[OK] Wrapper overlay prepared without firmware-name; using the matching boot-loaded bitstream.')
FIX_PL
    PL_DTBO="$directory/pl.dtbo"
    info "Compiling corrected source: $copy"
    dtc -@ -I dts -O dtb -i "$(dirname -- "$PL_DTS")" -o "$WORK_DIR/generated/pl.dtbo" "$copy" || die 'Overlay compilation failed.'
    cp -- "$WORK_DIR/generated/pl.dtbo" "$PL_DTBO"
    require_file "$PL_DTBO" || die 'PL overlay is unreadable or empty.'
    # Basic format check: an overlay must be a flattened DT containing overlay nodes.
    python3 - "$PL_DTBO" <<'CHECK_OVERLAY' || die 'PL overlay format check failed.'
import sys
from pathlib import Path
data = Path(sys.argv[1]).read_bytes()
if len(data) < 40 or data[:4] != bytes.fromhex("d00dfeed") or b"__overlay__\0" not in data:
    sys.exit("[ERROR] The selected file is not a recognizable device-tree overlay.")
CHECK_OVERLAY
    ok "PL overlay: $PL_DTBO"
    info 'The overlay must match the bitstream and the base DTB running on the board.'
}

export_wrapper() {
    local appdir=$1 ko=$2 source target name directory
    local code_dir="$WRAPPER_DIR/code" fpga_dir="$WRAPPER_DIR/fpga"
    section 'Organizing the project wrapper'
    # Validate all destinations before copying or moving any deliverable.
    for directory in "$WRAPPER_DIR" "$code_dir" "$fpga_dir"; do
        [[ ! -L "$directory" ]] || die "Refusing a symlinked wrapper directory: $directory"
        [[ ! -e "$directory" || -d "$directory" ]] || die "Not a directory: $directory"
    done
    local -a bitstreams=()
    for source in "$WRAPPER_DIR"/*; do
        [[ -f "$source" ]] || continue
        name=${source##*/}
        [[ "${name,,}" != boot.bin ]] || continue
        case "${name,,}" in *.bin|*.bit) bitstreams+=("$source") ;; esac
    done
    local -a targets=("$code_dir/$MODULE_ID.c" "$code_dir/$MODULE_ID.h"
        "$fpga_dir/$MODULE_ID.ko" "$fpga_dir/program_fpga.sh")
    for source in "${bitstreams[@]}"; do targets+=("$fpga_dir/${source##*/}"); done
    for target in "${targets[@]}"; do
        [[ ! -L "$target" ]] || die "Refusing to overwrite a symlink: $target"
        [[ ! -e "$target" || -f "$target" ]] || die "Not a regular file: $target"
        if [[ -e "$target" && "$FORCE" != true ]]; then
            die "Wrapper output already exists: $target. Use -f or --force to overwrite."
        fi
    done
    mkdir -p "$code_dir" "$fpga_dir"
    cp -- "$appdir/files/$MODULE_ID.c" "$appdir/files/$MODULE_ID.h" "$code_dir/"
    cp -- "$ko" "$fpga_dir/$MODULE_ID.ko"
    if [[ ! "$PL_DTBO" -ef "$fpga_dir/pl.dtbo" ]]; then
        cp -- "$PL_DTBO" "$fpga_dir/pl.dtbo"
    fi
    cat > "$fpga_dir/program_fpga.sh" <<'KR260_LOADER_EOF'
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
KR260_LOADER_EOF
    chmod +x "$fpga_dir/program_fpga.sh"
    for source in "${bitstreams[@]}"; do
        mv -- "$source" "$fpga_dir/${source##*/}"
        ok "Moved bitstream: ${source##*/} -> fpga/"
    done
    # Remove previous flat copies only when they match the newly exported files.
    # Keep differing legacy files instead of silently deleting user changes.
    for name in "$MODULE_ID.c" "$MODULE_ID.h" "$MODULE_ID.ko" pl.dtbo; do
        source="$WRAPPER_DIR/$name"
        case "$name" in *.c|*.h) target="$code_dir/$name" ;; *) target="$fpga_dir/$name" ;; esac
        if [[ -f "$source" && ! -L "$source" ]] && cmp -s -- "$source" "$target"; then
            rm -- "$source"
        fi
    done
    ok "Driver sources (.c, .h): $code_dir"
    ok "Board files (.ko, pl.dtbo, bitstreams, executable loader): $fpga_dir"
    info 'On the KR260, run: sudo ./program_fpga.sh from the fpga directory.'
}

create_and_build_module() {
    local appdir="$PROJECT_ROOT/project-spec/meta-user/recipes-modules/$RECIPE_NAME"
    section 'Creating or updating the module recipe'
    if [[ -d "$appdir" ]]; then
        [[ "$FORCE" == true ]] || die 'Existing module requires -f or --force.'
        info "Force mode: replacing generated files for $RECIPE_NAME"
        mkdir -p "$appdir/files"
    else
        petalinux-create modules --name "$RECIPE_NAME" --enable
    fi
    [[ -d "$appdir/files" ]] || die "Missing generated module directory: $appdir/files"
    cp -- "$WORK_DIR/generated/$MODULE_ID.c" "$WORK_DIR/generated/$MODULE_ID.h" "$appdir/files/"
    cat > "$appdir/files/Makefile" <<'MAKEFILE'
obj-m := @MODULE@.o

# Header directory is filled in by create_ptlnx_driver.sh for this project.
MY_CFLAGS += -g -DDEBUG -I"@INCLUDE_DIR@"
ccflags-y += $(MY_CFLAGS)

all:
	$(MAKE) -C $(KERNEL_SRC) M=$(CURDIR) modules

modules_install:
	$(MAKE) -C $(KERNEL_SRC) M=$(CURDIR) modules_install

clean:
	$(MAKE) -C $(KERNEL_SRC) M=$(CURDIR) clean
MAKEFILE
    cat > "$appdir/$RECIPE_NAME.bb" <<'RECIPE'
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
    sed -i "s/@MODULE@/$MODULE_ID/g" "$appdir/files/Makefile" "$appdir/$RECIPE_NAME.bb"
    # Escape the directory for Makefile syntax and sed replacement.
    local include_dir="$appdir/files"
    include_dir=${include_dir//\$/\$\$}
    include_dir=${include_dir//#/\\#}
    local include_replacement
    include_replacement=$(printf '%s' "$include_dir" | sed 's/[\\&|]/\\&/g')
    sed -i "s|@INCLUDE_DIR@|$include_replacement|g" "$appdir/files/Makefile"
    configure_fsbl_domain
    section 'Compiling the kernel module'
    info "Building recipe: $RECIPE_NAME"
    if [[ "$FORCE" == true ]]; then
        info 'Cleaning the module sstate before rebuilding.'
        petalinux-build -c "$RECIPE_NAME" -x do_cleansstate
        printf '\n'
    fi
    petalinux-build -c "$RECIPE_NAME"
    printf '\n'
    local deployed ko="$PROJECT_ROOT/images/linux/$MODULE_ID.ko"
    if ! deployed=$(find_deployed_module); then
        info 'No deployed .ko found yet; running the module deploy task explicitly.'
        petalinux-build -c "$RECIPE_NAME" -x do_deploy
        deployed=$(find_deployed_module) || die 'Module build succeeded but its .ko was not found in Yocto deploy output.'
    fi
    require_file "$deployed" || die "Unreadable deployed module: $deployed"
    mkdir -p "$PROJECT_ROOT/images/linux"
    [[ ! -L "$ko" ]] || die "Refusing to overwrite a symlink: $ko"
    if [[ ! "$deployed" -ef "$ko" ]]; then cp -- "$deployed" "$ko"; fi
    info "Yocto deploy output: $deployed"
    ok "Module compiled: $ko"
    prepare_pl_overlay
    export_wrapper "$appdir" "$ko"
    printf '\n'
    info 'Build the complete image separately if you want to include the enabled module in the rootfs.'
}

main() {
    parse_arguments "$@"
    trap cleanup EXIT
    section 'Selecting the module name'
    select_module_name
    section 'Checking the PetaLinux project and tools'
    prepare_project
    select_pl_description
    section 'Checking the generator and templates'
    while true; do
        if [[ -n "$GEN_DIR" ]]; then
            if validate_generator_directory; then
                break
            fi
        fi
        printf '\n'
        info 'Provide a directory containing one *.py, one *.c.template and one *.h.template.'
        printf 'Generator and templates directory: ' >&2
        if ! IFS= read -r GEN_DIR; then
            die 'Input ended before a valid directory was provided.'
        fi
        GEN_DIR=${GEN_DIR%$'\r'}
        if [[ -z "$GEN_DIR" ]]; then
            error 'The directory path must not be empty.'
        fi
    done
    section 'Selecting the synchronous FIFO'
    select_fifo
    section 'Generating the driver sources'
    generate_sources
    create_and_build_module
    section 'Completed'
    ok "Driver ready: $MODULE_ID.ko"
}

main "$@"
EMBEDDED_DRIVER_EOF
    bash "$local_driver" "${DRIVER_ARGS[@]}"
)

parse_combined_arguments "$@"
main "${PROJECT_ARGS[@]}"
