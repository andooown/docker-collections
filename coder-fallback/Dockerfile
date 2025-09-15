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

# Delete user 'ubuntu' if it exists
RUN if id "ubuntu" &>/dev/null; then \
      echo "Deleting user 'ubuntu'"; \
      userdel -f -r ubuntu || echo "Failed to delete ubuntu user"; \  
    else \
      echo "User 'ubuntu' does not exist"; \ 
    fi
# Create a non-root user 'vscode'
RUN useradd -m -s /bin/bash vscode && \
    usermod -aG sudo vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN mkdir -p /workspaces && \
    chown -R vscode:vscode /workspaces

COPY --chown=vscode:vscode entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER vscode
WORKDIR /home/vscode

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
