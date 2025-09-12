#!/usr/bin/env bash
set -euo pipefail

# Detect repository directory
REPO_DIR="${REPO_DIR:-}"
if [ -z "${REPO_DIR}" ]; then
  # Detect the first .git directory under /workspaces
  found="$(find /workspaces -mindepth 2 -maxdepth 3 -type d -name .git -printf '%h\n' 2>/dev/null | head -n1 || true)"
  if [ -n "${found}" ]; then
    REPO_DIR="${found}"
  else
    # Predict from directory name
    cand="$(ls -1 /workspaces 2>/dev/null | head -n1 || true)"
    REPO_DIR="/workspaces/${cand:-repo}"
  fi
fi

# Change ownership to the current user
sudo chown -R "$(id -u)":"$(id -g)" /workspaces || true
# Prevent "dubious ownership" warning
git config --global --add safe.directory "${REPO_DIR}" || true

# Set up git credentials if GITHUB_TOKEN is provided
if [ -n "${GITHUB_TOKEN:-}" ]; then
  git config --global credential.helper store
  printf "https://x-access-token:%s@github.com\n" "${GITHUB_TOKEN}" >> "${HOME}/.git-credentials"
fi

exec sleep infinity
