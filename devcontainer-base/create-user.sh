#!/bin/bash

set -e

USERNAME=${USERNAME:-vscode}

# Create a non-root user if it doesn't exist
if [ -z "$(getent passwd "${USERNAME}")" ]; then
  echo "Creating user '${USERNAME}'"
  useradd -m -s /bin/bash "${USERNAME}"
else
  echo "User '${USERNAME}' already exists"
fi

# Add user to sudo group and configure passwordless sudo
usermod -aG sudo "${USERNAME}"
printf '%s ALL=(ALL) NOPASSWD:ALL\n' "${USERNAME}" > /etc/sudoers.d/${USERNAME}
chmod 0440 /etc/sudoers.d/${USERNAME}

# Change shell to zsh if available
if [ -x /usr/bin/zsh ]; then
  echo "Changing shell for user '${USERNAME}' to zsh"
  chsh -s /usr/bin/zsh "${USERNAME}"
  touch /home/${USERNAME}/.zshrc
fi

# Create and configure workspaces directory
mkdir -p /workspaces
chown -R "${USERNAME}:${USERNAME}" /workspaces

echo "User '${USERNAME}' setup completed"
