#!/usr/bin/env bash
# Program the KR260 FPGA with the SDT .bin packaged by create_ptlnx_prj.sh.
# startupbash.service supplies its installed rootfs path via FPGA_BITSTREAM.
# Manual use: sudo bash program_fpga.sh /absolute/path/to/design.bin
# Run as root. This script does not mount the SD or load a device-tree overlay.

if (( $# > 1 )); then
    printf '[ERROR] Usage: program_fpga.sh [/absolute/path/to/design.bin]\n' >&2
    exit 2
fi
BITSTREAM="${1:-${FPGA_BITSTREAM:-}}"
if [[ -z "$BITSTREAM" ]]; then
    printf '[ERROR] No bitstream supplied. Use startupbash.service or pass the .bin path.\n' >&2
    exit 1
fi
if [[ ! -r "$BITSTREAM" || ! -s "$BITSTREAM" ]]; then
    printf '[ERROR] Bitstream missing, unreadable or empty: %s\n' "$BITSTREAM" >&2
    exit 1
fi

printf '[INFO] Starting FPGA programming.\n'
printf '[INFO] Bitstream: %s\n' "$BITSTREAM"

if fpgautil -b "$BITSTREAM"; then
    printf '[OK] fpgautil completed successfully.\n'
else
    status=$?
    printf '[ERROR] FPGA programming failed (exit code %s).\n' "$status" >&2
    exit "$status"
fi
