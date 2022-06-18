#!/usr/bin/env zsh

set -e

if ! [ -e $HOME/.asdf ]; then
    echo "▶️  Asdf setup"
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
fi

if ! [ -e $HOME/.oh-my-zsh ]; then
    echo "▶️  Oh my zsh setup"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc
fi

if ! command -v autojump &>/dev/null; then
    echo "▶️  Autojump setup"
    export SHELL=bash

    git clone --depth 1 https://github.com/wting/autojump.git
    cd autojump
    /usr/bin/python ./install.py
fi
