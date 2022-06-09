#!/usr/bin/env zsh

set -e

echo "▶️  Antigen setup"
curl -L git.io/antigen >$HOME/antigen.zsh

if ! [ -e $HOME/.fzf ]; then
    echo "▶️  Fzf setup"
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    yes Y | $HOME/.fzf/install
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
