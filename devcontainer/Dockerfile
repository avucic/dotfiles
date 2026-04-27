ARG BASE_IMAGE=debian:trixie-slim
FROM ${BASE_IMAGE}

USER root

# ── System packages ──────────────────────────────────────────────────────────
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      zsh git stow fzf ripgrep fd-find jq zoxide direnv \
      luarocks nodejs npm python3 python3-pip \
      curl unzip ca-certificates sudo \
      build-essential \
      sqlite3 libsqlite3-dev \
      rustc cargo \
      postgresql-client \
      openssh-client && \
    ln -sf "$(which fdfind)" /usr/local/bin/fd && \
    rm -rf /var/lib/apt/lists/*


# ── Neovim ───────────────────────────────────────────────────────────────────
RUN ARCH=$(dpkg --print-architecture) && \
    case "$ARCH" in \
      amd64) NVIM_ARCH=linux-x86_64 ;; \
      arm64) NVIM_ARCH=linux-arm64 ;; \
      *) echo "Unsupported arch: $ARCH"; exit 1 ;; \
    esac && \
    curl -fsSL "https://github.com/neovim/neovim/releases/download/stable/nvim-${NVIM_ARCH}.tar.gz" -o /tmp/nvim.tar.gz && \
    tar -xzf /tmp/nvim.tar.gz -C /opt && \
    rm /tmp/nvim.tar.gz && \
    NVIM_DIR=$(find /opt -maxdepth 1 -name 'nvim-linux*' -type d | head -1) && \
    ln -sf "$NVIM_DIR/bin/nvim" /usr/local/bin/nvim && \
    nvim --version | head -1

# ── Lazygit ──────────────────────────────────────────────────────────────────
RUN ARCH=$(dpkg --print-architecture) && \
    case "$ARCH" in \
      amd64) LG_ARCH=Linux_x86_64 ;; \
      arm64) LG_ARCH=Linux_arm64 ;; \
    esac && \
    LG_VERSION=$(curl -fsSL https://api.github.com/repos/jesseduffield/lazygit/releases/latest \
      | sed -n 's/.*"tag_name": *"v\([^"]*\)".*/\1/p') && \
    curl -fsSL "https://github.com/jesseduffield/lazygit/releases/download/v${LG_VERSION}/lazygit_${LG_VERSION}_${LG_ARCH}.tar.gz" \
    | tar -xz -C /usr/local/bin lazygit && \
    lazygit --version

# ── Eza ──────────────────────────────────────────────────────────────────────
RUN ARCH=$(dpkg --print-architecture) && \
    case "$ARCH" in \
      amd64) EZA_ARCH=x86_64-unknown-linux-gnu ;; \
      arm64) EZA_ARCH=aarch64-unknown-linux-gnu ;; \
    esac && \
    curl -fsSL "https://github.com/eza-community/eza/releases/latest/download/eza_${EZA_ARCH}.tar.gz" \
    | tar -xz -C /usr/local/bin && \
    eza --version | head -1


# # ── Dotfiles + install ───────────────────────────────────────────────────────
# COPY --from=dotfiles . /root/.dotfiles
#
RUN mkdir -p /root/.ssh && ssh-keyscan github.com gitlab.com >> /root/.ssh/known_hosts

RUN --mount=type=ssh bash /root/.dotfiles/install-image.sh && \
    rm -rf /root/.ssh/id_*


ENV DEVCONTAINER=true \
    ME_VAULT_DIR=/root/Notes/me \
    WORK_VAULT_DIR=/root/Notes/work \
    ZK_NOTEBOOK_DIR=/root/Notes/me

RUN npm install -g neovim
