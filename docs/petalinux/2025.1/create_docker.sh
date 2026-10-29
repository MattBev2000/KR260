#!/usr/bin/env bash
# Build the image and create one persistent container. Run once as a normal user.
set -Eeuo pipefail

usage() {
    cat <<'HELP'
Usage: ./create_docker.sh

Build image petalinux-ubuntu:2025.1 and create container petalinux-2025.1.
Keep this script beside Dockerfile, docs/ and ptlnx-prjs/.
An existing container with the same name is preserved and causes an error.
Run as your normal host account; sudo is used only for Docker if necessary.

  -h, --h, --help   Show help

After creation, open the container with ./start_docker.sh.
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

# Preserve the real host UID/GID for files written into the shared folders.
if ((EUID == 0)); then
    printf 'ERROR: Run ./create_docker.sh as your normal account, without sudo.\n' >&2
    exit 1
fi

BASE_DIR=$(dirname -- "$(realpath -- "${BASH_SOURCE[0]}")")
CONTAINER_ROOT=/opt/petalinux/2025.1
IMAGE_NAME=petalinux-ubuntu:2025.1
CONTAINER_NAME=petalinux-2025.1

if [[ ! -s "$BASE_DIR/Dockerfile" ]]; then
    printf 'ERROR: A nonempty Dockerfile is required beside this script.\n' >&2
    exit 1
fi

if ! command -v docker >/dev/null; then
    printf 'ERROR: Docker is not installed.\n' >&2
    exit 1
fi

# Elevate Docker alone if the account cannot access its daemon directly.
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

# Do not replace an existing container: it may contain installed tools or data.
if "${DOCKER[@]}" container inspect "$CONTAINER_NAME" >/dev/null 2>&1; then
    printf 'ERROR: Container %s already exists. Use ./start_docker.sh.\n' "$CONTAINER_NAME" >&2
    exit 1
fi

# Create host directories before mounting them, avoiding automatic root ownership.
for folder in docs ptlnx-prjs; do
    if ! mkdir -p "$BASE_DIR/$folder"; then
        printf 'ERROR: Cannot create %s. Check host permissions.\n' "$BASE_DIR/$folder" >&2
        exit 1
    fi
    if [[ ! -r "$BASE_DIR/$folder" || ! -w "$BASE_DIR/$folder" || ! -x "$BASE_DIR/$folder" ]]; then
        printf 'ERROR: Read/write/access permissions required on %s.\n' "$BASE_DIR/$folder" >&2
        exit 1
    fi
done

printf '\n========== Building the image ==========\n\n'
"${DOCKER[@]}" build \
    --build-arg "USER_UID=$(id -u)" \
    --build-arg "USER_GID=$(id -g)" \
    --file "$BASE_DIR/Dockerfile" \
    --tag "$IMAGE_NAME" \
    "$BASE_DIR"

printf '\n========== Creating the persistent container ==========\n\n'

# A foreground process keeps the container alive between shell sessions.
# Omit --rm so stopping the container preserves its internal filesystem.
# Shared SELinux labels support RHEL bind mounts; Yocto can require unshare,
# which Docker's default seccomp profile can block.
"${DOCKER[@]}" create \
    --name "$CONTAINER_NAME" \
    --init \
    --hostname ptlnx-20251 \
    --user admin \
    --security-opt seccomp=unconfined \
    --volume "$BASE_DIR/docs:$CONTAINER_ROOT/docs:rw,z" \
    --volume "$BASE_DIR/ptlnx-prjs:$CONTAINER_ROOT/ptlnx-prjs:rw,z" \
    --workdir "$CONTAINER_ROOT/ptlnx-prjs" \
    "$IMAGE_NAME" \
    sleep infinity

printf '\nImage and container created. Open with ./start_docker.sh.\n\n'

