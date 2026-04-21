#!/usr/bin/env bash
set -euo pipefail

# ── Config ────────────────────────────────────────────────────────────────────
DOTFILES_LOCATION=${DOTFILES_LOCATION:-"$HOME/.dotfiles"}
export DOTFILES_LOCATION

IS_DEVCONTAINER=${DEVCONTAINER:-false}
IS_MAC=$([ "$(uname)" = "Darwin" ] && echo true || echo false)
IS_ALPINE=$([ -f /etc/alpine-release ] && echo true || echo false)
DRY_RUN=${DRY_RUN:-false}

# ── Package definitions ───────────────────────────────────────────────────────
pkg_zsh() { brew="zsh"; apk="zsh"; }
pkg_git() { brew="git"; apk="git"; }
pkg_neovim() { brew="neovim"; apk="neovim"; }
pkg_tmux() { brew="tmux"; apk="tmux"; }
pkg_stow() { brew="stow"; apk="stow"; }
pkg_fzf() { brew="fzf"; apk="fzf"; }
pkg_ripgrep() { brew="ripgrep"; apk="ripgrep"; }
pkg_fd() { brew="fd"; apk="fd"; }
pkg_jq() { brew="jq"; apk="jq"; }
pkg_lazygit() { brew="lazygit"; apk="lazygit"; }
pkg_zoxide() { brew="zoxide"; apk="zoxide"; }
pkg_direnv() { brew="direnv"; apk="direnv"; }
pkg_luarocks() { brew="luarocks"; apk="luarocks"; }
pkg_node() { brew="node"; apk="npm"; }
pkg_python3() { brew="python3"; apk="python3"; }
pkg_curl() { brew="curl"; apk="curl"; }
pkg_unzip() { brew="unzip"; apk="unzip"; }
pkg_yazi() { brew="yazi"; apk="-"; }
pkg_shadow() { brew="-"; apk="shadow"; }
pkg_sqlite() { brew="sqlite"; apk="sqlite"; }
pkg_sqlite_dev()  { brew="-";      apk="sqlite-dev";  }
pkg_sqlite_libs() { brew="-";      apk="sqlite-libs"; }

# ── Platform package lists ────────────────────────────────────────────────────
COMMON_PACKAGES=(
  neovim
  zsh
  # tmux
  # git
  stow
  fzf
  ripgrep
  fd
  jq
  zoxide
  direnv
  luarocks
  node
  python3
  curl
  unzip
  sqlite
)

MAC_PACKAGES=(
  "${COMMON_PACKAGES[@]}"
  lazygit
  yazi
)

ALPINE_PACKAGES=(
  "${COMMON_PACKAGES[@]}"
  lazygit
  sqlite_dev
  sqlite_libs
)

LINUX_PACKAGES=(
  "${COMMON_PACKAGES[@]}"
  lazygit
)

# ── Stow packages (dotfile dirs to stow) ──────────────────────────────────────
STOW_PACKAGES=(
  nvim 
  zsh
  tmux
  git
 lazygit
)

# ── Helpers ───────────────────────────────────────────────────────────────────
log() { echo "$@"; }
info() { echo "ℹ️  $*"; }
ok() { echo "✅ $*"; }
warn() { echo "⚠️  $*"; }
die() {
  echo "❌ $*" >&2
  exit 1
}

run() {
  if [ "$DRY_RUN" = "true" ]; then
    echo "[dry-run] $*"
  else
    "$@"
  fi
}

# ── Homebrew ──────────────────────────────────────────────────────────────────
install_homebrew() {
  if command -v brew &>/dev/null; then
    info "Homebrew already installed"
    return
  fi

  if [ "$IS_ALPINE" = "true" ]; then
    info "Skipping Homebrew on Alpine — using apk"
    return
  fi

  log "🍺 Installing Homebrew..."
  # Homebrew install — add NONINTERACTIVE
  run /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [ "$IS_MAC" = "true" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
}

# ── Core: install a single named package ─────────────────────────────────────
# Exported so nested install.sh scripts can call: install_package lazygit
install_package() {
  local name="$1"
  local fn="pkg_${name}"

  if ! declare -f "$fn" >/dev/null; then
    warn "  $name not in registry — skipping"
    return
  fi

  local brew="" apk=""
  eval "$fn"

  local pkg=""
  if [ "$IS_ALPINE" = "true" ]; then
    pkg="$apk"
    [ "$pkg" = "-" ] && warn "  $name not available on Alpine" && return
    run apk add --no-cache "$pkg"
  else
    pkg="$brew"
    [ "$pkg" = "-" ] && warn "  $name not available via brew" && return
    run brew install "$pkg"
  fi

  ok "  installed $name ($pkg)"
}
export -f install_package
export IS_MAC IS_ALPINE DRY_RUN

# ── Install all platform packages ─────────────────────────────────────────────
install_all_packages() {
  local -a packages=()

  if [ "$IS_MAC" = "true" ]; then
    info "Platform: macOS"
    packages=("${MAC_PACKAGES[@]}")
  elif [ "$IS_ALPINE" = "true" ]; then
    info "Platform: Alpine"
    packages=("${ALPINE_PACKAGES[@]}")
    run apk update
  else
    info "Platform: Linux"
    packages=("${LINUX_PACKAGES[@]}")
  fi

  install_homebrew

  log "📦 Installing packages: ${packages[*]}"
  for pkg in "${packages[@]}"; do
    install_package "$pkg"
  done
}

# ── Stow ──────────────────────────────────────────────────────────────────────
stow_packages() {
  log "📦 Stowing dotfiles..."

  for package in "${STOW_PACKAGES[@]}"; do
    local pkg_path="${DOTFILES_LOCATION}/${package}"

    log ""
    log "──────────────────────────────────────"
    log "🔍 Package : ${package}"

    if [ ! -d "$pkg_path" ]; then
      warn "Skipping ${package} — directory not found"
      continue
    fi

    if [ -f "${pkg_path}/install.sh" ]; then
      log "🔧 Running install.sh for ${package}"
      run bash -c "cd '${pkg_path}' &&  ./install.sh"
    fi

    log "📁 Stowing ${package} → ${HOME}"
    run stow --restow --target="$HOME" --dir="$DOTFILES_LOCATION" "$package"

    ok "${package}"
  done
}

# ── Default shell ─────────────────────────────────────────────────────────────
set_default_shell() {
  local zsh_path
  zsh_path="$(command -v zsh 2>/dev/null)" || die "zsh not found in PATH"

  if ! grep -qF "$zsh_path" /etc/shells; then
    log "📝 Adding ${zsh_path} to /etc/shells"
    run bash -c "echo '${zsh_path}' | sudo tee -a /etc/shells"
  fi

  log "🐚 Setting default shell to ${zsh_path}"
  run chsh -s "$zsh_path" "$(whoami)"
}

# ── Main ──────────────────────────────────────────────────────────────────────
main() {
  [ "$DRY_RUN" = "true" ] && warn "DRY_RUN enabled — no changes will be made"

  install_all_packages
  stow_packages
  set_default_shell

  log "🎉 All done!"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
