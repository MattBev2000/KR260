# Ubuntu development environment; install PetaLinux manually after creation.
FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
ARG USER_UID=1000
ARG USER_GID=1000

# Install the tools and libraries used by PetaLinux and the project scripts.
RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates locales tzdata \
       bash bash-completion file less nano vim \
       build-essential gcc-multilib \
       git wget curl rsync openssh-client \
       python3 python3-pip python3-pexpect python3-jinja2 \
       python3-git python3-subunit python3-distro \
       gawk diffstat chrpath socat cpio \
       tar gzip bzip2 xz-utils zstd unzip \
       autoconf automake libtool libtool-bin \
       texinfo flex bison bc patch make \
       libssl-dev zlib1g-dev libncurses5-dev \
       libtinfo5 libncurses5 lib32z1 \
       zlib1g:i386 libstdc++6:i386 \
       libsdl1.2-dev libglib2.0-dev \
       libselinux1 gnupg net-tools iproute2 iputils-ping \
       xterm xvfb xauth screen pax expect tofrodos \
       lsb-release debianutils util-linux dnsutils \
       device-tree-compiler libacl1 lz4 \
    && locale-gen en_US.UTF-8 \
    && ln -sf /bin/bash /bin/sh \
    && rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV TERM=xterm-256color
ENV USER=mattia
ENV LOGNAME=mattia
ENV HOME=/home/mattia

# Keep the installation and shared-data paths explicit. Do not set PETALINUX
# here: the installed settings.sh script will initialize the vendor environment.
ENV PETALINUX_INSTALL_DIR=/opt/petalinux/2025.1
ENV DOCUMENTS_DIR=/opt/petalinux/docs
ENV PROJECTS_DIR=/opt/petalinux/projects

# Match the UID and GID of mattia on the Ubuntu host.
RUN groupadd --gid "${USER_GID}" mattia \
    && useradd --uid "${USER_UID}" --gid "${USER_GID}" \
       --create-home --shell /bin/bash mattia

# Prepare writable mount points in the image. At runtime, bind mounts replace
# these directories with host directories and preserve the HOST permissions.
# Image ownership cannot grant access to a root-owned directory on the host.
RUN install -d --owner=mattia --group=mattia --mode=0755 \
    /opt/petalinux \
    "${PETALINUX_INSTALL_DIR}" \
    "${DOCUMENTS_DIR}" \
    "${PROJECTS_DIR}"

# Do not install PetaLinux in this image: a bind mount over 2025.1 would hide it.
# Install it manually, as mattia, AFTER start_docker.sh mounts the host folders.
# Do not declare VOLUME here; the launcher supplies the three explicit mounts.
USER mattia
WORKDIR ${PROJECTS_DIR}

CMD ["/bin/bash"]

