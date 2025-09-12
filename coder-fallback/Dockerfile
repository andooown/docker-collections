
FROM ubuntu:24.04

ARG TARGETARCH

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
      build-essential \
      ca-certificates \
      curl \
      git \
      gpg \
      jq \
      locales \
      net-tools \
      sudo \
      unzip \
      vim \
      wget && \
      rm -rf /var/lib/apt/lists/*

# Setup locale
RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# Create a non-root user
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
