#!/usr/bin/env zsh

set -e

if ! [ -e $HOME/.asdf ]; then
    echo "▶️  Asdf setup"
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
    asdf plugin-add deno https://github.com/asdf-community/asdf-deno.git
    asdf plugin add ruby
    asdf plugin add nodejs
    asdf plugin add python
    asdf plugin add neovim

    asdf install ruby latest
    asdf install nodejs latest
    asdf install python latest
    asdf install neovim latest
    asdf install deno latest

    asdf global ruby latest
    asdf global nodejs latest
    asdf global python latest
    asdf global neovim latest
fi
