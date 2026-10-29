#!/usr/bin/env bash
# Reuse the persistent container. Never build images or create/remove containers.
set -Eeuo pipefail

usage() {
    cat <<'HELP'
Usage: ./start_docker.sh

Start container petalinux-2025.1 if stopped, then open Bash as admin.
If it is already running, reuse it and open another shell.
The shell starts in /opt/petalinux/2025.1/ptlnx-prjs.
Use exit to close the shell; the container stays running and is not deleted.

  -h, --h, --help   Show help

Run ./create_docker.sh once before using this script.
To stop separately: docker stop petalinux-2025.1
Use sudo for that command if your Docker access requires it.
HELP
}

if (($# > 0)); then
    case "$1" in
        -h|--h|--help)
            usage
            exit 0
            ;;
        *)
            printf 'ERROR: Unknown option. Use --help.\n' >&2
            exit 1
            ;;
    esac
fi

CONTAINER_NAME=petalinux-2025.1
CONTAINER_WORKDIR=/opt/petalinux/2025.1/ptlnx-prjs

if ! command -v docker >/dev/null; then
    printf 'ERROR: Docker is not installed.\n' >&2
    exit 1
fi

# Request elevated permissions only for Docker when needed.
DOCKER=(docker)
if ! docker info >/dev/null 2>&1; then
    if ! command -v sudo >/dev/null; then
        printf 'ERROR: Cannot access Docker and sudo is unavailable.\n' >&2
        exit 1
    fi
    printf 'Docker requires administrator access.\n'
    DOCKER=(sudo docker)
    "${DOCKER[@]}" info >/dev/null
fi

if ! "${DOCKER[@]}" container inspect "$CONTAINER_NAME" >/dev/null 2>&1; then
    printf 'ERROR: Container %s does not exist. Run ./create_docker.sh first.\n' "$CONTAINER_NAME" >&2
    exit 1
fi

STATUS=$("${DOCKER[@]}" container inspect --format '{{.State.Status}}' "$CONTAINER_NAME")
case "$STATUS" in
    running)
        printf '\nContainer already running: %s\n' "$CONTAINER_NAME"
        ;;
    created|exited)
        printf '\nStarting container: %s\n' "$CONTAINER_NAME"
        "${DOCKER[@]}" start "$CONTAINER_NAME"
        ;;
    *)
        printf 'ERROR: Container state is %s. Check docker ps -a before retrying.\n' "$STATUS" >&2
        exit 1
        ;;
esac

printf '\n========== Opening a shell as admin ==========\n\n'

# Open a new shell without replacing the container's persistent main process.
exec "${DOCKER[@]}" exec \
    --interactive \
    --tty \
    --user admin \
    --workdir "$CONTAINER_WORKDIR" \
    "$CONTAINER_NAME" \
    /bin/bash

