#!/usr/bin/env bash
set -euo pipefail

if ! command -v putty >/dev/null 2>&1; then
    echo "Please install PuTTY first: sudo apt install putty"
    exit 1
fi

shopt -s nullglob
ports=(/dev/serial/by-id/usb-Xilinx_KR_Carrier_Card_*-if01-port0)

if ((${#ports[@]} == 0)); then
    echo "KR260 not found. Check the power supply and micro-USB UART/JTAG cable."
    exit 1
fi

if ((${#ports[@]} == 1)); then
    device="${ports[0]}"
else
    echo "Multiple KR260 boards detected. Select a board:"
    select device in "${ports[@]}"; do
        [[ -n "$device" ]] && break
    done
fi

port="$(readlink -f -- "$device")"
log_dir="${XDG_STATE_HOME:-$HOME/.local/state}/kr260"
mkdir -p -- "$log_dir"
log_file="$log_dir/putty.log"

echo "KR260 console detected: $port"

if [[ -r "$port" && -w "$port" ]]; then
    nohup putty -serial "$port" -sercfg 115200,8,n,1,N \
        >"$log_file" 2>&1 </dev/null &
else
    if [[ "$(stat -c '%G' -- "$port")" != "dialout" ]]; then
        echo "Unexpected serial port permissions:"
        ls -l -- "$port"
        exit 1
    fi

    user="$(id -un)"

    if ! id -nG "$user" | tr ' ' '\n' | grep -qx dialout; then
        echo "Adding $user to the dialout group."
        sudo usermod -aG dialout "$user"
    fi

    # Apply the group to the new process without requiring a logout.
    nohup sg dialout -c \
        "exec putty -serial '$port' -sercfg 115200,8,n,1,N" \
        >"$log_file" 2>&1 </dev/null &
fi

echo "PuTTY started in the background (PID: $!)."
echo "Any errors are logged to: $log_file"
