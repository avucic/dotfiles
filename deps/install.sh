#!/usr/bin/env zsh

set -e

echo "▶️  Brew setup"

# brew install --cask taskwarrior-pomodoro
# brew install --cask taskwarrior-tui

for i in stow yarn stylua tmuxp sqlfluff rg direnv \
	pgformatter protobuf jq zoxide yaml-language-server \
	fd checkmake mike-engel/jwt-cli/jwt-cli nvr direnv zk code-minimap fd  \
	sqlfluff rust-analyzer viu tree htop taskd timewarrior nim vit \
	xclip wget silicon coreutils libpq wrk bash bat fzf highlight vips libyaml autojump eza httpie gh git-delta \
  neovim-remote imgcat
do
	if ! command -v $i &>/dev/null; then
  	brew install $i
	fi
done

echo "▶️  NPM setup"

npm install -g @fsouza/prettierd
npm install -g dotenv
# npm install -g markserv
# npm install -g emmet-ls

pip3 install httplib2 oauth2client
# echo "▶️  Pip setup"
# pip install \
#   --global-option=build_ext \
#   --global-option="-I/usr/local/include" \
#   --global-option="-L/opt/X11/lib"  \
#   lookatme.contrib.image_ueberzug
