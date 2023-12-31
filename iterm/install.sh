#!/usr/bin/env zsh

set -e
echo $PWD

 tic -x ./iterm/xterm-256color-italic.terminfo
 tic -x ./iterm/tmux-256color-italic.terminfo
 tic -x ./iterm/xterm-24bit.terminfo

 git clone https://github.com/Karmenzind/monaco-nerd-fonts ~/Downloads/monaco-nerd-font
