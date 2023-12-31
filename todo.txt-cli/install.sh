#!/usr/bin/env zsh

# https://github.com/todotxt/todo.txt-cli/wiki/Todo.sh-Add-on-Directory

set -e

brew install entr
# if [ ! -e ~/.todo.actions.d/note ]; then
#   mkdir -p ~/.todo.actions.d
#
#   git clone https://github.com/Genzer/todo.txt-note ~/.todo.actions.d/note
#   chmod u+x ~/.todo.actions.d/note/note
# fi

if [ ! -e ~/.todo.actions.d/repeat ]; then
  wget https://raw.githubusercontent.com/drobertadams/todo.txt-cli-addons/master/repeat/repeat  -P ~/.todo.actions.d/repeat/
  chmod u+x ~/.todo.actions.d/repeat/repeat
fi

if [ ! -e ~/.todo.actions.d/edit ]; then
  wget https://raw.githubusercontent.com/mbrubeck/todo.txt-cli/master/todo.actions.d/edit -P ~/.todo.actions.d/edit/
  chmod u+x ~/.todo.actions.d/edit/edit
fi

if [ ! -e ~/.todo.actions.d/watch ]; then
  git clone https://github.com/Kynda/todot.txt-watch ~/.todo.actions.d/watch
fi
