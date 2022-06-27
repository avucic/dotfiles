#!/usr/bin/env zsh

set -e

if ! [ -e $HOME/.asdf ]; then
    echo "▶️  Asdf setup"
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
fi


go get golang.org/x/tools/gopls@latest
go get golang.org/x/tools/gomodifytags@latest
go get golang.org/x/tools/impl@latest
go get golang.org/x/tools/goplay@latest
go get golang.org/x/tools/dlv@latest
go get golang.org/x/tools/staticcheck@latest
go get golang.org/x/tools/gotests@latest
