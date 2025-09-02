FROM ubuntu:24.04

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

RUN curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-linux-x64' --output /tmp/vscode_cli.tar.gz && \
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
