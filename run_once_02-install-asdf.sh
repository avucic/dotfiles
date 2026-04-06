#!/bin/bash
set -e

if ! [ -e "$HOME/.asdf" ]; then
  echo "==> Installing asdf..."
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1

  . "$HOME/.asdf/asdf.sh"

  echo "==> Adding asdf plugins..."
  asdf plugin add ruby
  asdf plugin add nodejs
  asdf plugin add python
  asdf plugin add deno https://github.com/asdf-community/asdf-deno.git
  asdf plugin add neovim

  echo "==> Installing latest versions..."
  asdf install ruby latest
  asdf install nodejs latest
  asdf install python latest
  asdf install deno latest
  asdf install neovim latest

  asdf global ruby latest
  asdf global nodejs latest
  asdf global python latest
  asdf global deno latest
  asdf global neovim latest
fi
