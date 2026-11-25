#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="kr260-petalinux:2025.1"
CONTAINER_NAME="kr260-petalinux-dev"

HOST_HOME="/home/mattia"
PROJECTS_DIR="$HOST_HOME/petalinux-projects"

# Run as the regular host user.
if [[ "$(id -u)" == 0 ]]; then
    echo "ERROR: run this script without sudo."
    exit 1
fi

# Check Docker.
if ! command -v docker >/dev/null 2>&1; then
    echo "ERROR: Docker is not installed."
    exit 1
fi

if ! docker info >/dev/null 2>&1; then
    echo "ERROR: Docker is not accessible."
    exit 1
fi

# Open another shell if the container is already running.
if docker container inspect "$CONTAINER_NAME" >/dev/null 2>&1; then
    running="$(docker inspect --format '{{.State.Running}}' "$CONTAINER_NAME")"

    if [[ "$running" == "true" ]]; then
        echo "Opening another shell in $CONTAINER_NAME..."

        exec docker exec -it \
            --user "$(id -u):$(id -g)" \
            --env "HOME=$HOST_HOME" \
            --workdir "$PROJECTS_DIR" \
            "$CONTAINER_NAME" /bin/bash
    fi

    echo "ERROR: container $CONTAINER_NAME exists but is stopped."
    echo "Inspect it with: docker ps -a"
    exit 1
fi

# Check the image before creating a new container.
if ! docker image inspect "$IMAGE_NAME" >/dev/null 2>&1; then
    echo "ERROR: Docker image not found: $IMAGE_NAME"
    exit 1
fi

# Check host directories.
for path in /opt "$HOST_HOME" "$PROJECTS_DIR"; do
    if [[ ! -d "$path" ]]; then
        echo "ERROR: directory not found: $path"
        exit 1
    fi
done

if [[ ! -r "$HOST_HOME" || ! -w "$HOST_HOME" || ! -x "$HOST_HOME" ]]; then
    echo "ERROR: insufficient permissions on $HOST_HOME"
    exit 1
fi

# Graphics are disabled by default.
X11_ARGS=(
    --env "DISPLAY="
    --env "XAUTHORITY="
)

# Enable graphics only for a local desktop session with X11 authorization.
if [[ -n "${SSH_CONNECTION:-}${SSH_CLIENT:-}${SSH_TTY:-}" ]]; then
    echo "SSH session detected: graphics disabled."
elif [[ -z "${DISPLAY:-}" || ! -d /tmp/.X11-unix ]]; then
    echo "Host X11 display is unavailable: graphics disabled."
elif ! command -v xauth >/dev/null 2>&1; then
    echo "xauth is not installed: graphics disabled."
else
    AUTH_DATA="$(xauth nlist "$DISPLAY" 2>/dev/null || true)"

    if [[ -z "$AUTH_DATA" ]]; then
        echo "No X11 authorization found for $DISPLAY: graphics disabled."
    else
        # Prepare temporary X11 authorization.
        AUTH_DIR="$(mktemp -d)"
        AUTH_FILE="$AUTH_DIR/Xauthority"
        trap 'rm -rf -- "$AUTH_DIR"' EXIT

        touch "$AUTH_FILE"

        # Support the container's different hostname.
        if printf '%s\n' "$AUTH_DATA" |
            sed 's/^..../ffff/' |
            xauth -f "$AUTH_FILE" nmerge -; then

            # The containing directory remains private.
            chmod 644 "$AUTH_FILE"

            X11_ARGS=(
                --env "DISPLAY=$DISPLAY"
                --env "XAUTHORITY=/tmp/kr260.Xauthority"
                --mount "type=bind,source=/tmp/.X11-unix,target=/tmp/.X11-unix,readonly"
                --mount "type=bind,source=$AUTH_FILE,target=/tmp/kr260.Xauthority,readonly"
            )

            echo "Graphics enabled on $DISPLAY."
        else
            echo "Cannot prepare X11 authorization: graphics disabled."
        fi
    fi
fi

echo "Starting $CONTAINER_NAME..."
echo "Host $HOST_HOME -> container $HOST_HOME (read/write)"
echo "Host /opt -> container /opt (read/write)"
echo "Using host UID=$(id -u), GID=$(id -g)"
echo "Run this script in another host terminal to open another shell."
echo "Keep this main shell open while using the container."

# Mount the host home and /opt.
# Do not use exec: the EXIT trap cleans up after Docker exits.
docker run --rm --init -it \
    --name "$CONTAINER_NAME" \
    --user "$(id -u):$(id -g)" \
    --env "HOME=$HOST_HOME" \
    --env "USER=$(id -un)" \
    --env "LOGNAME=$(id -un)" \
    --env "PROJECTS_DIR=$PROJECTS_DIR" \
    "${X11_ARGS[@]}" \
    --mount "type=bind,source=/opt,target=/opt" \
    --mount "type=bind,source=$HOST_HOME,target=$HOST_HOME" \
    --workdir "$PROJECTS_DIR" \
    "$IMAGE_NAME" /bin/bash