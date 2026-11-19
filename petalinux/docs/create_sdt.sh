#!/usr/bin/env bash
# Generate a ZynqMP SDT using AMD Vitis/Vivado 2025.1 SDTGen.
#
# USAGE:
#   ./generate_sdt_2025_1.sh INPUT.xsa OUTPUT_DIR [-path SETTINGS_FILE] [BOARD_DTS]
#
# EXAMPLE:
#   ./generate_sdt_2025_1.sh ./design.xsa ./sdt_out \
#       -path /opt/vivado/2025.1/Vitis/settings64.sh
#
# ARGUMENTS:
#   INPUT.xsa      Hardware design exported from Vivado 2025.1.
#   OUTPUT_DIR     Destination directory; must be absent or empty.
#   -path FILE     Optional override for the settings file shown below.
#                  Default: /opt/vivado/2025.1/Vitis/settings64.sh
#   BOARD_DTS      Optional SDTGen board identifier, not a BSP filename.
#                  May appear before or after the -path option.
#
# SETUP:
#   chmod +x generate_sdt_2025_1.sh
#   The selected settings file is sourced automatically.
#   No separate Tcl file or manual source command is required.
#   Linux and Bash are required; use the Tcl version on Windows.
#
# OUTPUT:
#   Checks that system-top.dts, pcw.dtsi and pl.dtsi exist and are nonempty.
#   Existing output is never deleted; failed generation may leave partial files.
#   Temporary Tcl files are removed on exit.
#   Exit status 0 means generation and output checks completed successfully.

set -euo pipefail

usage() {
    echo "Usage: $0 INPUT.xsa OUTPUT_DIR [-path SETTINGS_FILE] [BOARD_DTS]"
}

if (( $# == 1 )) && [[ "$1" == "--help" || "$1" == "-h" ]]; then
    usage
    exit 0
fi
if (( $# < 2 )); then
    usage >&2
    exit 2
fi

SDT_ARGUMENTS=("$1" "$2")
shift 2
SETTINGS_FILE="/opt/2025.1/Vitis/settings64.sh"
SETTINGS_PATH_SET=0
BOARD_DTS=""

while (( $# > 0 )); do
    case "$1" in
        -path)
            if (( $# < 2 )) || [[ -z "$2" || "$2" == -* ]]; then
                echo "The -path option requires a settings64.sh file path." >&2
                exit 2
            fi
            if (( SETTINGS_PATH_SET )); then
                echo "Specify -path only once." >&2
                exit 2
            fi
            SETTINGS_FILE="$2"
            SETTINGS_PATH_SET=1
            shift 2
            ;;
        -*)
            echo "Unknown option: $1" >&2
            usage >&2
            exit 2
            ;;
        *)
            if [[ -n "$BOARD_DTS" || -z "$1" ]]; then
                echo "Specify at most one nonempty BOARD_DTS argument." >&2
                exit 2
            fi
            BOARD_DTS="$1"
            shift
            ;;
    esac
done

if [[ ! -f "$SETTINGS_FILE" || ! -r "$SETTINGS_FILE" ]]; then
    echo "Settings file not found or not readable: $SETTINGS_FILE" >&2
    exit 1
fi
if [[ -n "$BOARD_DTS" ]]; then
    SDT_ARGUMENTS+=("$BOARD_DTS")
fi

# Make the settings path absolute and preserve the caller's working directory.
SDT_CALLER_DIR="$PWD"
SETTINGS_FILE="$(cd -- "$(dirname -- "$SETTINGS_FILE")" && pwd -P)/$(basename -- "$SETTINGS_FILE")"
printf 'Loading Vitis environment: %s\n' "$SETTINGS_FILE"
# Vendor environment scripts may reference unset variables.
set +eu
source "$SETTINGS_FILE"
SETTINGS_STATUS=$?
set -euo pipefail
if (( SETTINGS_STATUS != 0 )); then
    echo "Failed to load the Vitis environment: $SETTINGS_FILE" >&2
    exit "$SETTINGS_STATUS"
fi
cd -- "$SDT_CALLER_DIR"

SDT_PROGRAM="${SDTGEN:-sdtgen}"
if ! command -v "$SDT_PROGRAM" >/dev/null 2>&1; then
    echo "SDTGen not found after loading the selected environment: $SDT_PROGRAM" >&2
    echo "Check that Vitis/Vivado 2025.1 includes SDTGen." >&2
    exit 1
fi
printf 'Using SDTGen: %s\n' "$(command -v "$SDT_PROGRAM")"

TASK_TMP="$(mktemp -d "${TMPDIR:-/tmp}/generate-sdt-2025-1.XXXXXXXX")"
cleanup() {
    rm -f -- "$TASK_TMP/generate_sdt.tcl"
    rmdir -- "$TASK_TMP" 2>/dev/null || true
}
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

cat > "$TASK_TMP/generate_sdt.tcl" <<'SDT_TCL_EOF'
# Generate a ZynqMP SDT with AMD Vitis/Vivado 2025.1 SDTGen.
# Linux:   sdtgen generate_sdt_2025_1.tcl INPUT.xsa OUTPUT_DIR [BOARD_DTS]
# Windows: sdtgen.bat generate_sdt_2025_1.tcl INPUT.xsa OUTPUT_DIR [BOARD_DTS]
# Use an XSA exported by Vivado 2025.1 and the 2025.1 SDTGen launcher.
# OUTPUT_DIR must be absent or empty. No existing output is deleted.

namespace eval ::sdt_validation {
    variable format_errors {}
}

proc ::sdt_validation::check_format {command code result operation} {
    variable format_errors
    if {$code == 1} {
        lappend format_errors "$command: $result"
    }
}

proc main {arguments} {
    if {[llength $arguments] < 2 || [llength $arguments] > 3} {
        error "Usage: sdtgen generate_sdt_2025_1.tcl INPUT.xsa OUTPUT_DIR \[BOARD_DTS\]"
    }

    # SDTGen 2025.1 exposes these commands directly, without an XSCT prefix.
    foreach command {set_dt_param generate_sdt} {
        if {![llength [info commands ::$command]]} {
            error "SDTGen command unavailable: $command. Run this script with Vitis/Vivado 2025.1 sdtgen, not xsct or tclsh."
        }
    }

    foreach value [lrange $arguments 0 1] {
        if {[string trim $value] eq ""} {
            error "INPUT.xsa and OUTPUT_DIR must not be empty."
        }
    }
    set xsa [file normalize [string map {\\ /} [lindex $arguments 0]]]
    set outdir [file normalize [string map {\\ /} [lindex $arguments 1]]]

    if {![file isfile $xsa]} {error "XSA file not found: $xsa"}
    if {![string equal -nocase [file extension $xsa] .xsa]} {
        error "Input must be an .xsa file: $xsa"
    }
    if {[file exists $outdir]} {
        if {![file isdirectory $outdir]} {
            error "Output is not a directory: $outdir"
        }
        set entries [concat [glob -nocomplain -directory $outdir *] \
                            [glob -nocomplain -directory $outdir .*]]
        foreach entry $entries {
            if {[file tail $entry] ni {. ..}} {
                error "Output directory is not empty. Choose a new directory: $outdir"
            }
        }
    }

    set_dt_param -xsa $xsa -dir $outdir
    if {[llength $arguments] == 3} {
        set board [string trim [lindex $arguments 2]]
        if {$board eq ""} {error "BOARD_DTS must not be empty when specified."}
        set_dt_param -board_dts $board
    }

    # Do not apply the 2024.2 clock workaround to the 2025.1 generator.
    # Retain the original additional check for swallowed format errors.
    set ::sdt_validation::format_errors {}
    trace add execution ::format leave ::sdt_validation::check_format
    try {
        generate_sdt
    } finally {
        trace remove execution ::format leave ::sdt_validation::check_format
    }
    if {[llength $::sdt_validation::format_errors]} {
        error "SDT generation reported formatting errors:\n[join $::sdt_validation::format_errors \n]"
    }

    foreach name {system-top.dts pcw.dtsi pl.dtsi} {
        set path [file join $outdir $name]
        if {![file isfile $path]} {error "Expected output missing: $path"}
        if {[file size $path] == 0} {error "Empty output file: $path"}
    }
    puts "SDT generated: $outdir"
    puts "Top-level file: [file join $outdir system-top.dts]"
}

if {[catch {main $argv} message options]} {
    puts stderr "ERROR: $message"
    puts stderr [dict get $options -errorinfo]
    exit 1
}
exit 0
SDT_TCL_EOF

"$SDT_PROGRAM" "$TASK_TMP/generate_sdt.tcl" "${SDT_ARGUMENTS[@]}"
