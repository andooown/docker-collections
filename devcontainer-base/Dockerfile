
FROM ubuntu:24.04

ARG TARGETARCH
ARG USERNAME=vscode

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
      build-essential \
      ca-certificates \
      cmake \
      curl \
      file \
      git \
      gpg \
      jq \
      libclang-dev \
      libpq-dev \
      libssl-dev \
      libudev-dev \
      llvm-dev \
      locales \
      make \
      net-tools \
      pkg-config \
      sudo \
      unzip \
      vim \
      wget \
      zsh && \
    rm -rf /var/lib/apt/lists/*

# Setup locale
RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# Create a non-root user
RUN if [ -z "$(getent passwd "${USERNAME}")" ]; then \
      useradd -m -s /bin/bash "${USERNAME}"; \
    fi && \
    usermod -aG sudo "${USERNAME}" && \
    printf '%s ALL=(ALL) NOPASSWD:ALL\n' "${USERNAME}" > /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME} && \
    if [ -x /usr/bin/zsh ]; then \
      chsh -s /usr/bin/zsh "${USERNAME}"; \
    fi && \
    mkdir -p /workspaces && \
    chown -R "${USERNAME}:${USERNAME}" /workspaces 

USER $USERNAME
WORKDIR "/home/${USERNAME}"

# Node
ENV NVM_DIR="/home/${USERNAME}/.nvm"
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash && \
    bash -c ". $NVM_DIR/nvm.sh && nvm install 22"

# Rust
ENV PATH="/home/${USERNAME}/.cargo/bin:$PATH"
RUN curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain stable -y && \
    rustup component add rustfmt clippy

# Python・uv
ENV PATH="/home/${USERNAME}/.local/bin:$PATH"
RUN curl --proto '=https' --tlsv1.2 -LsSf https://github.com/astral-sh/uv/releases/download/0.8.17/uv-installer.sh | sh && \
    uv python install 3.12
