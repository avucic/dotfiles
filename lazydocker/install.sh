#!/usr/bin/env zsh


set -e

if ! command -v tmux &>/dev/null; then
  brew install lazydocker
fi
