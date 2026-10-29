FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
ARG USER_UID=1000
ARG USER_GID=1000

# Install the required development tools and libraries.
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
    && locale-gen en_US.UTF-8 \
    && ln -sf /bin/bash /bin/sh \
    && rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV TERM=xterm-256color
ENV USER=admin
ENV LOGNAME=admin
ENV HOME=/home/admin

# Match the host account IDs for files written into shared directories.
RUN groupadd --gid "${USER_GID}" admin \
    && useradd --uid "${USER_UID}" --gid "${USER_GID}" \
       --create-home --shell /bin/bash admin \
    && mkdir -p \
       /opt/petalinux/2025.1/docs \
       /opt/petalinux/2025.1/ptlnx-prjs \
    && chown -R admin:admin /opt/petalinux/2025.1

# Start as a normal user in the project directory.
USER admin
WORKDIR /opt/petalinux/2025.1/ptlnx-prjs

CMD ["/bin/bash"]
