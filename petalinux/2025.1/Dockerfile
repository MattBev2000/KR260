# Ubuntu development environment for PetaLinux and Vivado 2025.1.
# Install AMD tools manually after starting the container.
FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
ARG USER_UID=1000
ARG USER_GID=1000

# Install development tools, PetaLinux dependencies and GUI applications.
RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates locales tzdata \
       bash bash-completion file less nano vim \
       gedit gir1.2-peas-1.0 dbus-x11 \
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
       xterm xvfb xauth x11-utils \
       libx11-6 libxext6 libxrender1 libxtst6 libxi6 \
       libxt6 libxft2 libxinerama1 libxrandr2 libxcursor1 \
       libsm6 libice6 libfontconfig1 libfreetype6 \
       fontconfig fonts-dejavu-core \
       libgl1 libgl1-mesa-dri \
       screen pax expect tofrodos \
       lsb-release debianutils util-linux dnsutils \
       device-tree-compiler libacl1 lz4 \
    && locale-gen en_US.UTF-8 \
    && ln -sf /bin/bash /bin/sh \
    && rm -rf /var/lib/apt/lists/*

# Match the host user's numeric UID and GID.
RUN groupadd --gid "${USER_GID}" mattia \
    && useradd --uid "${USER_UID}" --gid "${USER_GID}" \
       --create-home --shell /bin/bash mattia

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV TERM=xterm-256color

ENV USER=mattia
ENV LOGNAME=mattia
ENV HOME=/home/mattia

# The launcher mounts host /opt at container /opt.
# Host projects are mounted at /home/mattia.
ENV PETALINUX_INSTALL_DIR=/opt/petalinux/2025.1
ENV DOCUMENTS_DIR=/opt/petalinux/docs
ENV PROJECTS_DIR=/home/mattia

# Runtime bind mounts retain the host's ownership and permissions.
RUN install -d --owner=mattia --group=mattia --mode=0755 \
    /opt/petalinux \
    "${PETALINUX_INSTALL_DIR}" \
    "${DOCUMENTS_DIR}" \
    "${PROJECTS_DIR}"

# DISPLAY, XAUTHORITY and the X11 socket are supplied by start_docker.sh.
# Save AMD installations in the mounted /opt directory.

USER mattia
WORKDIR /home/mattia

CMD ["/bin/bash"]