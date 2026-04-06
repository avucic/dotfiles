#!/bin/bash
set -e

if ! [ -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "==> Installing TPM (Tmux Plugin Manager)..."
  git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
