#!/usr/bin/env zsh


set -e

if ! [ -e $HOME/.bin ]; then
  mkdir ~/.bin
  ln -s /Users/vucinjo/Documents/psd /Users/vucinjo/.bin
fi
