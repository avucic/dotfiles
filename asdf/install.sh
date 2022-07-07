#!/usr/bin/env zsh

set -e

if ! [ -e $HOME/.asdf ]; then
    echo "▶️  Asdf setup"
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
fi
