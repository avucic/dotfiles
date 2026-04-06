#!/bin/bash
set -e

echo "==> Setting up ~/.bin symlink..."
if [ -d "$HOME/Documents/psd" ] && ! [ -L "$HOME/.bin" ]; then
  ln -sf "$HOME/Documents/psd" "$HOME/.bin"
fi
