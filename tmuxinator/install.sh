#!/usr/bin/env zsh


set -e

if ! [ -e $HOME/.tmuxinator ]; then
    gem install tmuxinator
    wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh -O /usr/local/share/zsh/site-functions/_tmuxinator
    echo "▶️  Tmuxinator setup"
fi
