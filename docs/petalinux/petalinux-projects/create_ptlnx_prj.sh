#!/usr/bin/env bash
# Create and build a PetaLinux 2025.1 ZynqMP project from a board BSP and SDT.
# Configure the operating system and package an SD WIC image for a board
# with compatible boot firmware already installed in QSPI.
# After the build, generate BOOT.BIN and include it in the WIC boot partition.
# This script does not flash QSPI or change the board's boot mode.
#
# Run inside Linux (for example, your Ubuntu PetaLinux container):
#   chmod +x create_ptlnx_prj.sh
#   ./create_ptlnx_prj.sh -n my-project -sdt /path/to/sdt
# Enter your Bash script path when prompted, or press Enter to skip startup
# app creation. Alternatively, use --startup-script FILE or --no-startup.
# The new app's output is logged to both journal and system console.
# PetaLinux settings are loaded automatically. See --help for all options.
# At completion, copy create_ptlnx_driver.sh from /opt/petalinux/docs.
# If unavailable, ask for another path; Enter skips the optional copy.
# The final cd affects this script only; the calling terminal is unchanged.
# The startup script runs as root through systemd once per Linux boot.
# It must finish, require no terminal input, and use target board file paths.
# The SDT .bin is also installed in the rootfs and passed through FPGA_BITSTREAM.
# Install any other script-specific files and dependencies separately.

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
  ./create_ptlnx_prj.sh -n NAME -sdt DIR [-bsp FILE] [-cfg DIR] [options]

Options:
  -n NAME           Project directory name, relative to the launch directory
  -sdt DIR          Vivado/Vitis 2025.1 SDT directory, containing one .bit
                    and one .bin file (subdirectories are searched too)
  -bsp FILE         PetaLinux 2025.1 board BSP; otherwise search beside this
                    script, select if several exist, or ask if none is found
  -cfg DIR          Search for config, rootfs_config and kernel user.cfg
                    Each file is optional: found -> silent; missing -> menu
  --settings FILE   Default: /opt/petalinux/2025.1/settings.sh
  --startup-script FILE
                    Install FILE as /usr/bin/startupbash and enable its service
                    Include the SDT .bin and pass its rootfs path as FPGA_BITSTREAM
  --no-startup      Skip startup app creation without prompting
                    With neither option, ask for a path; Enter skips creation
  --resume          Resume after a successful first build; reuse the existing
                    project configuration, without -cfg
  -h, --h, --help   Display this help and exit without changing anything

Examples:
  ./create_ptlnx_prj.sh -n my-project -sdt /path/to/SDT
  ./create_ptlnx_prj.sh -n my-project -sdt /path/to/SDT \
    -bsp /path/to/board.bsp -cfg /path/to/saved-configs
  ./create_ptlnx_prj.sh --resume -n my-project -sdt /path/to/SDT

Workflow:
  1. Source the PetaLinux 2025.1 settings.
  2. Create the project from the board BSP.
  3. Run petalinux-config --get-hw-description with the SDT directory.
  4. Configure the kernel, create the optional startup app, then build.
  5. Run petalinux-config -c rootfs.
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
applied to project-spec/configs/config before each build, including --resume
and imported -cfg configurations. Other menu selections are preserved.
Kernel configuration uses petalinux-config -c kernel --silentconfig when
user.cfg is supplied through -cfg. Otherwise it opens the kernel menu.
With --resume, an existing project kernel user.cfg selects silent mode.
Kernel compilation is handled by the full system build.
With --resume, skip project creation, hardware import and the first build.
Empty input and --no-startup leave all existing apps unchanged on resume.
--startup-script and --no-startup are mutually exclusive.
The startup app requires systemd as the rootfs init manager. Select systemd
in Image Features -> Init-manager when configuring the rootfs.
The service runs a finite initialization script as root, with working directory
/. Use target absolute paths and do not use sudo. Network connectivity and
FPGA programming are not automatically awaited by this service.
Inspect on the board: systemctl status startupbash.service
Read logs on the board: journalctl -u startupbash.service -b
The startup app includes the selected SDT .bin under the rootfs firmware
directory, in xilinx/startupbash/, keeping its original filename. The service
sets FPGA_BITSTREAM to its installed path. program_fpga.sh reads this variable;
no SD mount is needed. The .bin remains included in the WIC boot partition too.
The generated service uses journal+console for both stdout and stderr.
Console means the board's system console, normally its configured serial port;
it is not the build host terminal or an arbitrary SSH session.

The -cfg directory accepts config and rootfs_config either directly or under
project-spec/configs/. An optional kernel user.cfg is accepted directly or
under project-spec/meta-user/recipes-kernel/linux/linux-xlnx/.
All explicit relative paths are resolved before entering the project.

Enable rootfs.tar.gz in Image Packaging Configuration for WIC creation.
The boot partition contains BOOT.BIN, boot.scr, Image, system.dtb and the original .bit and .bin
found recursively in the SDT directory. Exactly one nonempty .bit and one
nonempty .bin are required. Both are copied unchanged, with their original
filenames, into <project>/<project>_wrapper alongside the WIC image.
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
    if [[ -n "${STARTUP_TEMP:-}" ]]; then
        rm -f -- "$STARTUP_TEMP"
    fi
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
STARTUP_SCRIPT=
STARTUP_MODE=ask
STARTUP_TEMP=
STARTUP_CREATED=false
SETTINGS=/opt/petalinux/2025.1/settings.sh
RESUME=false
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
            --startup-script)
                (($# >= 2)) || die 'Missing value for --startup-script.'
                [[ "$STARTUP_MODE" == ask ]] || die 'Specify only one startup option.'
                [[ -n "$2" && "$2" != -* ]] || die 'Supply a script path, or use --no-startup.'
                STARTUP_SCRIPT=$2
                STARTUP_MODE=file
                shift 2
                ;;
            --no-startup)
                [[ "$STARTUP_MODE" == ask ]] || die 'Specify only one startup option.'
                STARTUP_MODE=skip
                shift
                ;;
            --resume)
                RESUME=true
                shift
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
    if [[ "$RESUME" == true ]]; then
        if [[ ! -d "$PROJECT_NAME" || -L "$PROJECT_NAME" ]]; then
            die "Existing project directory not found or is a symlink: $PROJECT_NAME"
        fi
        if [[ -n "$CFG_DIR" ]]; then
            die '--resume uses the existing project configuration; do not combine it with -cfg.'
        fi
    else
        if [[ -e "$PROJECT_NAME" || -L "$PROJECT_NAME" ]]; then
            die "Project already exists: $PROJECT_NAME. Use --resume after a successful first build."
        fi
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
select_startup_script() {
    if [[ "$STARTUP_MODE" == ask ]]; then
        ask STARTUP_SCRIPT 'Startup Bash script path (Enter to skip): '
    fi
    if [[ -z "$STARTUP_SCRIPT" ]]; then
        info 'Skipping startup app creation; existing apps are unchanged.'
        return
    fi
    resolve_file STARTUP_SCRIPT
    STARTUP_TEMP=$(mktemp "${TMPDIR:-/tmp}/ptlnx-startup.XXXXXXXX")
    sed 's/\r$//' "$STARTUP_SCRIPT" > "$STARTUP_TEMP"
    if ! bash -n "$STARTUP_TEMP"; then
        die "Bash syntax check failed: $STARTUP_SCRIPT"
    fi
    ok "Startup script selected: $STARTUP_SCRIPT"
}

# Create all app files here; no separate helper script is needed.
configure_startup_app() {
    [[ -n "$STARTUP_SCRIPT" ]] || return 0
    local appdir="$PROJECT_ROOT/project-spec/meta-user/recipes-apps/startupbash"
    if [[ -e "$appdir" || -L "$appdir" ]]; then
        die "App already exists: $appdir. Review it manually; use --no-startup to preserve it on resume."
    fi
    section 'Creating the startup Bash app'
    petalinux-create apps --template install --name startupbash --enable
    [[ -d "$appdir/files" ]] || die 'PetaLinux did not create the expected startupbash app directory.'
    install -m 0755 "$STARTUP_TEMP" "$appdir/files/startupbash"
    install -m 0644 "$BINARY" "$appdir/files/$BINARY_NAME"

    cat > "$appdir/files/startupbash.service" <<'SERVICE'
[Unit]
Description=User-provided KR260 startup Bash script

[Service]
Type=oneshot
User=root
WorkingDirectory=/
Environment="FPGA_BITSTREAM=@FIRMWARE_DIR@/@BITSTREAM_NAME@"
ExecStart=/bin/bash /usr/bin/startupbash
RemainAfterExit=yes
StandardOutput=journal+console
StandardError=journal+console

[Install]
WantedBy=multi-user.target
SERVICE

    cat > "$appdir/startupbash.bb" <<'RECIPE'
SUMMARY = "User-provided Bash initialization script"
LICENSE = "CLOSED"

SRC_URI = "file://startupbash file://startupbash.service file://@BITSTREAM_NAME@"
S = "${WORKDIR}"

inherit systemd features_check
REQUIRED_DISTRO_FEATURES = "systemd"
RDEPENDS:${PN} += "bash fpga-manager-script"
PACKAGE_ARCH = "${MACHINE_ARCH}"

SYSTEMD_SERVICE:${PN} = "startupbash.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/startupbash ${D}${bindir}/startupbash
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/startupbash.service ${D}${systemd_system_unitdir}/startupbash.service
    install -d ${D}${nonarch_base_libdir}/firmware/xilinx/startupbash
    install -m 0644 ${WORKDIR}/@BITSTREAM_NAME@ ${D}${nonarch_base_libdir}/firmware/xilinx/startupbash/@BITSTREAM_NAME@
    sed -i 's|@FIRMWARE_DIR@|${nonarch_base_libdir}/firmware/xilinx/startupbash|g' ${D}${systemd_system_unitdir}/startupbash.service
}

FILES:${PN} += "${systemd_system_unitdir}/startupbash.service"
FILES:${PN} += "${nonarch_base_libdir}/firmware/xilinx/startupbash"
RECIPE
    # BINARY_NAME was validated to contain only filename-safe characters.
    sed -i "s|@BITSTREAM_NAME@|$BINARY_NAME|g" \
        "$appdir/startupbash.bb" "$appdir/files/startupbash.service"
    STARTUP_CREATED=true
    ensure_startup_selected
    ok 'Created startupbash: automatic execution as root at each Linux boot.'
    info 'Startup app output: journal+console'
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

resume_project() {
    cd -- "$PROJECT_NAME"
    PROJECT_ROOT=$(pwd -P)
    local required_files=(
        project-spec/configs/config
        project-spec/configs/rootfs_config
        images/linux/rootfs.tar.gz
        images/linux/Image
        images/linux/system.dtb
    )

    for file in "${required_files[@]}"; do
        if ! [[ -s "$file" ]]; then
            die "Cannot resume after first build: missing $file"
        fi
    done
    info "Resuming after the first build: $PROJECT_ROOT"
    info 'Use the same SDT directory that was imported into this project.'
    configure_sstate_mirror
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
    configure_startup_app

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
    elif [[ "$RESUME" == true && -r "$fragment" && -s "$fragment" ]]; then
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

    mkdir -p "$EXPORT"
    for source in "$BITSTREAM" "$BINARY"; do
        if [[ ! -f "$source" || ! -r "$source" || ! -s "$source" ]]; then
            die "FPGA input is no longer readable or is empty: $source"
        fi
        destination="$EXPORT/${source##*/}"
        if [[ ! "$source" -ef "$destination" ]]; then
            cp -- "$source" "$destination"
        fi
        ok "FPGA file copied to wrapper: $destination"
    done
}

# Copy the optional driver helper; Enter skips it when no source is available.
copy_driver_helper() {
    local source=/opt/petalinux/docs/create_ptlnx_driver.sh
    local destination="$PROJECT_ROOT/create_ptlnx_driver.sh"
    local answer

    section 'Copying the driver helper'
    while [[ ! -f "$source" || ! -r "$source" ]]; do
        info "Driver helper not found or not readable: $source"
        if [[ ! -t 0 ]]; then
            info 'No interactive input available; skipping the driver helper copy.'
            return 0
        fi
        if ! read -r -p 'Enter the driver script path (or its directory), or press Enter to skip: ' answer; then
            info 'No path supplied; skipping the driver helper copy.'
            return 0
        fi
        answer=${answer%$'\r'}
        if [[ -z "$answer" ]]; then
            info 'No path supplied; skipping the driver helper copy.'
            return 0
        fi
        if [[ "$answer" == '~/'* ]]; then
            answer="$HOME/${answer:2}"
        fi
        source=$answer
        if [[ -d "$source" ]]; then
            source="$source/create_ptlnx_driver.sh"
        fi
    done

    if [[ ! "$source" -ef "$destination" ]]; then
        cp -- "$source" "$destination"
    fi
    ok "Driver helper ready: $destination"
}

# Keep the requested configuration/build order explicit.
main() {
    parse_arguments "$@"
    trap cleanup EXIT

    section 'Checking inputs'
    validate_arguments
    resolve_argument_paths
    select_fpga_files
    select_startup_script

    if [[ "$RESUME" == false ]]; then
        section 'Selecting the board BSP'
        select_board_bsp
    fi

    section 'Loading PetaLinux 2025.1'
    load_petalinux_environment

    if [[ "$RESUME" == true ]]; then
        section 'Resuming the existing project'
        resume_project
        configure_kernel
        configure_startup_app
    else
        section 'Creating the project'
        create_and_build_project
    fi

    section 'Configuring rootfs'
    configure_rootfs
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

    copy_driver_helper
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

main "$@"
