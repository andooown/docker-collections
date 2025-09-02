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

RUN echo "code code/add-microsoft-repo boolean true" | debconf-set-selections && \
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/keyrings/packages.microsoft.gpg && \
  echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | tee /etc/apt/sources.list.d/vscode.list > /dev/null && \
  apt-get update && \
  apt-get install -y code

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
