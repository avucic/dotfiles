#!/usr/bin/env bash
set -e

echo "DEBUG: arg1='$1', arg2='$2'"
BASE_IMAGE="${1:-dotfiles-box}"
TAG="${2:-${BASE_IMAGE}-dev}"
echo "DEBUG: BASE_IMAGE='$BASE_IMAGE', TAG='$TAG'"

ssh-add ~/.ssh/id_ed25519 2>/dev/null || true

DOCKER_BUILDKIT=1 docker build \
  --no-cache \
  --ssh default \
  --build-arg BASE_IMAGE="$BASE_IMAGE" \
  --build-context dotfiles="$HOME/.dotfiles" \
  -t "$TAG" \
  "$HOME/.dotfiles/devcontainer"
