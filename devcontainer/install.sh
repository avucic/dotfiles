#!/usr/bin/env bash
set -e
#
# DOTFILES_REPO="https://github.com/avucic/dotfiles"
# DOTFILES_BRANCH="refactoring"
# DOTFILES_DIR="$HOME/.dotfiles"
#
# apt-get update -y && apt-get install -y stow git curl tmux unzip zsh
#
# # Clone dotfiles
# if [ ! -d "$DOTFILES_DIR" ]; then
#   git clone --branch "$DOTFILES_BRANCH" --depth 1 "$DOTFILES_REPO" "$DOTFILES_DIR"
# fi
#
# cd "$DOTFILES_DIR"
#
# # echo 'cd /rails' >>"$HOME/.zshrc"
#
# ./install.sh

echo "➡️ Running post-create setup..."

# Try to switch to zsh (ignore failure)
if command -v zsh >/dev/null 2>&1; then
  chsh -s "$(which zsh)" "$(whoami)" 2>/dev/null || true
  echo "✔ zsh set (if permitted)"
else
  echo "ℹ zsh not installed"
fi

# Configure global gitignore
git config --global core.excludesfile /root/.gitignore || true
echo "✔ git global ignore configured"

echo "✅ Done"
