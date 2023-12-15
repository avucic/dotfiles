#!/usr/bin/env zsh


set -e

if ! command -v tmux &>/dev/null; then
  brew install tmux
fi


# if ! [ -e $HOME/.tmux.conf ]; then
    ln -sf "${DOTFILES_LOCATION}/tmux/.tmux.conf" "${HOME}/.tmux.conf"
    git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo "▶️  Tmux setup"
# fi
