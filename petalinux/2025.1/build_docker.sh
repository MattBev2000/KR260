#!/usr/bin/env bash set -euo pipefail

IMAGE_NAME="kr260-petalinux:2025.1"

HOST_INSTALL="/opt/petalinux/2025.1" HOST_DOCS="/opt/petalinux/docs" HOST_PROJECTS="/home/mattia/petalinux-projects"

command -v docker >/dev/null 2>&1 || { echo "ERRORE: Docker non installato." exit 1 }

docker info >/dev/null 2>&1 || { echo "ERRORE: Docker non accessibile." exit 1 }

docker image inspect "$IMAGE_NAME" >/dev/null 2>&1 || { echo "ERRORE: Immagine Docker non trovata." exit 1 }

for path in "HOSTINSTALL""HOST_DOCS" "$HOST_PROJECTS"; do [[ -d "$path" ]] || { echo "ERRORE: Directory non trovata: $path" exit 1 } done

echo "Avvio KR260 PetaLinux 2025.1..."

exec docker run --rm --init -it
--mount "type=bind,source=$HOST_INSTALL,target=/opt/petalinux/2025.1"
--mount "type=bind,source=$HOST_DOCS,target=/opt/petalinux/docs"
--mount "type=bind,source=$HOST_PROJECTS,target=/opt/petalinux/projects"
--workdir /opt/petalinux/projects
"$IMAGE_NAME" /bin/bash
