#!/usr/bin/env bash
set -euo pipefail

export DEVCONTAINER=true

if [ ! -f "$HOME/.env" ]; then
  cat <<'EOF' >"$HOME/.env"
ME_VAULT_DIR=/root/Notes/me
WORK_VAULT_DIR=/root/Notes/work
ZK_NOTEBOOK_DIR=/root/Notes/me
EOF
fi
