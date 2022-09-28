#!/usr/bin/env zsh

set -e

echo "▶️  Brew setup"

for i in stow yarn stylua tmuxp sqlfluff rg direnv \
	pgformatter protobuf jq zoxide yaml-language-server \
	fd checkmake jwt-cli nvr direnv zk code-minimap fd \
	sqlfluff
do
	if ! command -v $i &>/dev/null; then
  brew install $i
fi
done
