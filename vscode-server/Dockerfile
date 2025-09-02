FROM ubuntu:24.04

ARG TARGETARCH

RUN apt-get update

RUN apt-get install -y locales && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

RUN apt-get install -y \
      curl \
      wget \
      vim \
      git \
      net-tools \
      build-essential \
      gpg \
      ca-certificates \
      sudo && \
      rm -rf /var/lib/apt/lists/*

RUN case "${TARGETARCH}" in \
      amd64) VSCODE_ARCH="cli-alpine-x64" ;; \
      arm64) VSCODE_ARCH="cli-alpine-arm64" ;; \
      *) echo "Unsupported architecture: ${TARGETARCH}" && exit 1 ;; \
    esac && \
    wget -O /tmp/vscode_cli.tar.gz 'https://code.visualstudio.com/sha/download?build=stable&os=${VSCODE_ARCH}' && \
    tar -xf /tmp/vscode_cli.tar.gz -C /tmp && \
    chmod +x /tmp/code && \
    mv /tmp/code /usr/local/bin/code && \
    rm /tmp/vscode_cli.tar.gz

RUN useradd -m -s /bin/bash vscode && \
    usermod -aG sudo vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN mkdir -p /workspace \
      /home/vscode/.vscode \
      /home/vscode/.vscode-server && \
    chown -R vscode:vscode \
      /workspace \
      /home/vscode/.vscode \
      /home/vscode/.vscode-server

USER vscode
WORKDIR /home/vscode
