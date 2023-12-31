#!/usr/bin/env zsh


set -e

if ! command -v topydo &>/dev/null; then
  pip3 install topydo
  pip3 install 'topydo[columns]'
fi
