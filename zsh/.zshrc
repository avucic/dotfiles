# -----------------------------------------------------------------------------
# Helper Functions
# -----------------------------------------------------------------------------
# Adds a path to the PATH variable if it doesn't already exist.
# Usage: _add_to_path "/path/to/add" [prepend|append]
_add_to_path() {
  local new_path="$1"
  local position="${2:-prepend}" # default to prepend

  if [[ -d "$new_path" ]]; then
    case ":$PATH:" in
      *":$new_path:"*) ;; # Path already exists, do nothing
      *)
        if [[ "$position" == "prepend" ]]; then
          export PATH="$new_path:$PATH"
        else
          export PATH="$PATH:$new_path"
        fi
        ;;
    esac
  fi
}


# -----------------------------------------------------------------------------
# Core Environment Variables
# -----------------------------------------------------------------------------
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color # or wezterm, xterm-kitty, screen-256color
export COLORTERM='24bit'
export ERL_AFLAGS="-kernel shell_history enabled" # enable history in iex
export DISABLE_AUTO_TITLE='true'


# -----------------------------------------------------------------------------
# Essential Sources & Setup
# -----------------------------------------------------------------------------
source ~/.env

# Znap: Fast Zsh Plugin Manager
[[ -r ~/.znap/znap.zsh ]] || \
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git ~/.znap
source ~/.znap/znap.zsh
zstyle ':znap:*' repos-dir ~/.znap/custom
export ZSH_CUSTOM=~/.znap/custom

# asdf: Language Version Manager
. $HOME/.asdf/asdf.sh
# . $HOME/.asdf/completions/asdf.bash

# iTerm2 Shell Integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# -----------------------------------------------------------------------------
# Path Modifications
# -----------------------------------------------------------------------------
# Prepend important binaries
_add_to_path "/Users/vucinjo/.bin" "prepend"
_add_to_path "$HOME/dotfiles/bin" "prepend"
# Append common binaries
_add_to_path "/usr/local/bin" "append"

# Conditional Go paths
if command -v go &> /dev/null; then
  _add_to_path "$(go env GOPATH)/bin" "append"
  if [[ -n "$GOROOT" ]]; then
    _add_to_path "$GOROOT/bin" "append"
  fi
  # Add GOPATH/bin if it's distinct from `go env GOPATH`/bin
  if [[ -n "$GOPATH" && "$GOPATH/bin" != "$(go env GOPATH)/bin" ]]; then
    _add_to_path "$GOPATH/bin" "append"
  fi
fi


# -----------------------------------------------------------------------------
# Neovim & Development Related Exports
# -----------------------------------------------------------------------------
export NVIM_PIPE=/tmp/nvim-$(basename $PWD)
export NVIM_LISTEN_ADDRESS=${NVIM_PIPE}
export EDITOR="nvim"

# Zettelkasten & Todo
export ZK_NOTEBOOK_DIR='/Users/vucinjo/Dropbox/Notes'
export TODO_DIR="~/Dropbox/todo"
export TODO_FILE="~/Dropbox/todo/todo.txt"
export DONE_FILE="~/Dropbox/todo/done.txt"
export TODOTXT_CFG_FILE=$HOME/.config/todo.txt-cli/conf.cfg

# FZF
export FZF_DEFAULT_OPTS='--preview "pygmentize {}" --color dark --bind "?:toggle-preview" --preview-window "right:50%:hidden"'

export ZSH_AI_PROVIDER="gemini"


# -----------------------------------------------------------------------------
# Znap Plugin Sourcing
# -----------------------------------------------------------------------------
# `znap prompt` makes your prompt visible in just 15-40ms!
znap prompt sindresorhus/pure
#
# eval "$(starship init zsh)"
znap prompt

znap source ohmyzsh/ohmyzsh \
  lib/{git,grep,history,key-bindings} \
  plugins/{git,cp,docker-compose,rake,bundler,ruby,tmux,direnv,fzf,gitignore,history,tmuxinator,zsh-ai}


# `znap source` starts plugins.
znap source z-shell/zsh-eza
znap source zsh-users/zsh-syntax-highlighting
znap source zsh-users/zsh-autosuggestions
znap source olets/zsh-abbr
znap source MichaelAquilina/zsh-you-should-use
znap source matheusml/zsh-ai
# znap source marlonrichert/zsh-autocomplete
# znap source zsh-users/zsh-completions

# znap source go-task/task lib/completion/zsh/_task

# `znap eval` makes evaluating generated command output up to 10 times faster.
znap eval iterm2 'curl -fsSL https://iterm2.com/shell_integration/zsh'

# -----------------------------------------------------------------------------
# Conditional Hooks & Completions
# -----------------------------------------------------------------------------
# direnv hook
if command -v direnv &>/dev/null; then
  eval "$(direnv hook zsh)"
fi

# zoxide hook
if command -v zoxide &> /dev/null; then
 eval "$(zoxide init zsh --cmd j)"
fi


# todo.txt-cli completion
source /opt/homebrew/etc/bash_completion.d/todo_completion complete -F _todo t


# -----------------------------------------------------------------------------
# Fixes & Specific Configurations
# -----------------------------------------------------------------------------
# Zsh Autosuggestions: in neovim terminal auto suggestions not visible
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=#666666

# oh-my-zsh docker completions (commented in original)
# [[ -r ~/.znap/completions/_docker ]] || ln -s ~/.znap/custom/ohmyzsh/ohmyzsh/plugins/docker/completions/* ~/.znap/completions/


# -----------------------------------------------------------------------------
# Custom Functions
# -----------------------------------------------------------------------------
dstats() { docker stats --all --format "table {{.ID}}\t{{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}" }
dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }

delete_snapshots() {
  for d in $(tmutil listlocalsnapshotdates | grep "-"); do sudo tmutil deletelocalsnapshots $d; done
}

kill-port() {
  readonly port=${1:?"The port must be specified."}
  echo $(lsof -t -i:${port})
  kill -9 $(lsof -t -i:${port})
}


# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------
alias tsk=task
alias t="/opt/homebrew/bin/todo.sh"
alias n="nvim"
