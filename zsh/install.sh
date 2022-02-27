#!/usr/bin/env zsh

set -e

curl -L git.io/antigen >$HOME/antigen.zsh

if ! [ -e $HOME/.fzf ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    yes Y | $HOME/.fzf/install
fi

if ! [ -e $HOME/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc
fi

if command -v autojump &>/dev/null; then
    git clone git://github.com/wting/autojump.git $HOME/autojump
    yes Y | $HOME/autojump/install.py
fi

[ -f $HOME/.zshrc ] && rm $HOME/.zshrc
[ -f $HOME/.antigenrc ] && rm $HOME/.antigenrc
ln -sf "${DOTFILES_LOCATION}/zsh/.zshrc" "${HOME}/.zshrc"
ln -sf "${DOTFILES_LOCATION}/zsh/.antigenrc" "${HOME}/.antigenrc"
