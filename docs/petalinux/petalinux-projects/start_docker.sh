#!/usr/bin/env bash
set -euo pipefail

die() { printf 'ERRORE: %s\n' "$*" >&2; exit 1; }
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
IMAGE_NAME=${IMAGE_NAME:-kr260-petalinux:2025.1}
HOST_PROJECTS=${HOST_PROJECTS:-/home/mattia/petalinux-projects}
HOST_DOCS=${HOST_DOCS:-/opt/petalinux/docs}
HOST_INSTALL=${HOST_INSTALL:-/opt/petalinux/2025.1}

command -v docker >/dev/null || die 'Docker non installato o non disponibile nel PATH.'
[[ $(uname -m) == x86_64 ]] || die 'Questa configurazione richiede un computer x86_64.'
[[ $(id -u) == 1000 && $(id -g) == 1000 ]] ||
    die 'Esegui come mattia (UID/GID 1000:1000), senza sudo.'
docker info >/dev/null 2>&1 ||
    die 'Docker non accessibile. Verifica che sia avviato e che mattia possa usarlo senza sudo.'

for path in "$HOST_PROJECTS" "$HOST_DOCS" "$HOST_INSTALL"; do
    [[ "$path" == /* ]] || die "Serve un percorso assoluto: $path"
    [[ "$path" != *','* ]] || die "Il percorso non deve contenere virgole: $path"
    [[ -d "$path" ]] || die "Cartella mancante: $path. Segui prima la procedura."
    [[ -r "$path" && -w "$path" && -x "$path" ]] ||
        die "Cartella non accessibile in lettura/scrittura: $path"
done

# The launcher lives in petalinux-projects, separately from the Dockerfile.
# Support the repository layout and the documented Ubuntu installation layout.
if [[ -z "${DOCKERFILE_DIR:-}" ]]; then
    if [[ -f "$SCRIPT_DIR/../2025.1/Dockerfile" ]]; then
        DOCKERFILE_DIR=$(cd -- "$SCRIPT_DIR/../2025.1" && pwd -P)
    else
        DOCKERFILE_DIR=/home/mattia/petalinux_container
    fi
fi
[[ -f "$DOCKERFILE_DIR/Dockerfile" ]] ||
    die "Dockerfile non trovato: $DOCKERFILE_DIR/Dockerfile. Imposta DOCKERFILE_DIR."
DOCKERFILE_DIR=$(cd -- "$DOCKERFILE_DIR" && pwd -P)
docker build \
    --build-arg USER_UID=1000 \
    --build-arg USER_GID=1000 \
    --tag "$IMAGE_NAME" \
    "$DOCKERFILE_DIR"

# Check access inside the container too: rootless Docker can map IDs differently.
docker run --rm \
    --mount "type=bind,source=$HOST_INSTALL,target=/opt/petalinux/2025.1" \
    --mount "type=bind,source=$HOST_DOCS,target=/opt/petalinux/docs" \
    --mount "type=bind,source=$HOST_PROJECTS,target=/opt/petalinux/projects" \
    "$IMAGE_NAME" /bin/bash -c '
        for path in /opt/petalinux/2025.1 /opt/petalinux/docs /opt/petalinux/projects; do
            [[ -r "$path" && -w "$path" && -x "$path" ]] || {
                printf "Cartella non accessibile dal container: %s\n" "$path" >&2
                exit 1
            }
        done
    ' || die 'Verifica i permessi delle cartelle e la mappatura utenti di Docker.'

run_args=(--rm --init -i)
if [[ -t 0 && -t 1 ]]; then
    run_args+=(-t)
fi
if (( $# == 0 )); then
    set -- /bin/bash
fi
exec docker run "${run_args[@]}" \
    --mount "type=bind,source=$HOST_INSTALL,target=/opt/petalinux/2025.1" \
    --mount "type=bind,source=$HOST_DOCS,target=/opt/petalinux/docs" \
    --mount "type=bind,source=$HOST_PROJECTS,target=/opt/petalinux/projects" \
    --workdir /opt/petalinux/projects \
    "$IMAGE_NAME" "$@"
