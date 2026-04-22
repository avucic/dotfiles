#!/usr/bin/env bash
set -euo pipefail

export DOTFILES_LOCATION="${DOTFILES_LOCATION:-/root/.dotfiles}"
export HOME="${HOME:-/root}"

# ── Config ───────────────────────────────────────────────────────────────────
STOW_PACKAGES=(
  nvim
  zsh
  tmux
  git
  lazygit
)

STOW_CONFLICTS=(
  .zshrc
  .gitconfig
  .tmux.conf
)

# ── Stow ─────────────────────────────────────────────────────────────────────
echo "📁 Stowing dotfiles..."
cd "$DOTFILES_LOCATION"

for f in "${STOW_CONFLICTS[@]}"; do
  [ -e "$HOME/$f" ] && [ ! -L "$HOME/$f" ] && rm "$HOME/$f"
done

for pkg in "${STOW_PACKAGES[@]}"; do
  if [ -d "$pkg" ]; then
    stow --restow --target="$HOME" --dir="$DOTFILES_LOCATION" "$pkg"
    echo "  ✓ $pkg"
  else
    echo "  ⊘ $pkg (not found)"
  fi
done

# ── Znap ─────────────────────────────────────────────────────────────────────
[ ! -e "$HOME/.znap" ] &&
  git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git "$HOME/.znap"

# ── Nvim plugins ─────────────────────────────────────────────────────────────
echo "💤 Baking nvim plugins..."
# nvim --headless "+Lazy! sync" +qa 2>&1 | tail -30 || true
# nvim --headless "+TSUpdateSync" +qa 2>&1 | tail -30 || true

# ── Shell ────────────────────────────────────────────────────────────────────
# ZSH_PATH="$(command -v zsh)"
# grep -qF "$ZSH_PATH" /etc/shells || echo "$ZSH_PATH" >>/etc/shells
# chsh -s "$ZSH_PATH" root

echo "✅ Image seed done"
