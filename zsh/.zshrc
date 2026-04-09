# ── Platform detection ────────────────────────────────────────────────────────
IS_MAC=false
IS_LINUX=false
IS_DEVCONTAINER=false
[[ "$(uname)" == "Darwin" ]] && IS_MAC=true
[[ "$(uname)" == "Linux" ]] && IS_LINUX=true
[[ -n "${DEVCONTAINER:-}" ]] && IS_DEVCONTAINER=true
export IS_MAC IS_LINUX IS_DEVCONTAINER

# ── Env ───────────────────────────────────────────────────────────────────────
export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export TERM=xterm-256color
export COLORTERM='24bit'
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=#666666
export FZF_DEFAULT_OPTS='--preview "cat {}" --color dark --bind "?:toggle-preview" --preview-window "right:50%:hidden"'
export ZSH_AI_PROVIDER="gemini"
export DISABLE_AUTO_TITLE='true'

ZSH_TMUX_AUTOQUIT=true
ZSH_TMUX_CONFIG=$HOME/.tmux.conf

# Auto install TPM plugins on first run
if [ -d ~/.tmux/plugins/tpm ] && [ ! -d ~/.tmux/plugins/tmux-onedark-theme ]; then
  ~/.tmux/plugins/tpm/bin/install_plugins
fi

# shellcheck source=/dev/null
[[ -f "$HOME/.env" ]] && source "$HOME/.env"

# ── Znap ──────────────────────────────────────────────────────────────────────
ZNAP_DIR="$HOME/.znap"
# shellcheck source=/dev/null
source "$ZNAP_DIR/znap.zsh"
zstyle ':znap:*' repos-dir "$ZNAP_DIR/custom"

# ── Prompt ────────────────────────────────────────────────────────────────────
# ── Interactive only ──────────────────────────────────────────────────────────
if [[ ! -o interactive ]] || [[ ! -t 1 ]]; then
  return
fi
znap prompt sindresorhus/pure

# Load specific OMZ libs and plugins after oh-my-zsh.sh
znap source ohmyzsh/ohmyzsh \
  lib/{git,grep,history,key-bindings} \
  plugins/{git,cp,docker-compose,rake,bundler,ruby,tmux,direnv,fzf,gitignore,history,tmuxinator}

# ── Plugins ───────────────────────────────────────────────────────────────────
znap source zsh-users/zsh-syntax-highlighting
znap source zsh-users/zsh-autosuggestions
znap source olets/zsh-abbr
znap source MichaelAquilina/zsh-you-should-use
znap source matheusml/zsh-ai

# ── Tool hooks ────────────────────────────────────────────────────────────────
znap eval iterm2 'curl -fsSL https://iterm2.com/shell_integration/zsh'

command -v direnv &>/dev/null && eval "$(direnv hook zsh)"
command -v zoxide &>/dev/null && eval "$(zoxide init zsh --cmd j)"

# ── Aliases ───────────────────────────────────────────────────────────────────
alias n="nvim"
alias cl="clear"

# ── Platform-specific configs ─────────────────────────────────────────────────
# shellcheck source=/dev/null
$IS_DEVCONTAINER && [[ -f "$HOME/.zshrc.devcontainer" ]] && source "$HOME/.zshrc.devcontainer"
# shellcheck source=/dev/null
$IS_MAC && [[ -f "$HOME/.zshrc.mac" ]] && source "$HOME/.zshrc.mac"
# shellcheck source=/dev/null
$IS_LINUX && ! $IS_DEVCONTAINER && [[ -f "$HOME/.zshrc.linux" ]] && source "$HOME/.zshrc.linux"
# shellcheck source=/dev/null
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
export PATH="$HOME/.devcontainers/bin:$PATH"
