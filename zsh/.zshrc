export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

[[ -r ~/.znap/znap.zsh ]] ||
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git ~/.znap

source ~/.znap/znap.zsh

zstyle ':znap:*' repos-dir ~/.znap/custom

if command -v direnv &>/dev/null; then
  eval "$(direnv hook zsh)"
fi

# `znap prompt` makes your prompt visible in just 15-40ms!
znap prompt sindresorhus/pure

export ZSH_CUSTOM=~/.znap/custom

# doesn't work as plugin
[[ -r ~/.znap/completions/_docker ]] || ln -s ~/.znap/custom/ohmyzsh/ohmyzsh/plugins/docker/completions/* ~/.znap/completions/
[[ -r ~/.znap/completions/_topydo ]] || ln -s ~/.znap/custom/ajnasz/topydo.zsh/_topydo ~/.znap/completions/
# [[ -r ~/.znap/completions/_httpie ]] || ln -s ~/.znap/custom/ohmyzsh/ohmyzsh/plugins/httpie/* ~/.znap/completions/

znap source ohmyzsh/ohmyzsh \
  lib/{git,grep,history,key-bindings,completion} \
  plugins/{git,cp,docker-compose,rake,autojump,bundler,ruby,tmux,direnv,asdf,fzf,gitignore,history,tmuxinator}


# fix rust plugins/rust \

# `znap source` starts plugins.
znap source MohamedElashri/exa-zsh
znap source zsh-users/zsh-syntax-highlighting
znap source zsh-users/zsh-completions
znap source zsh-users/zsh-autosuggestions
znap source olets/zsh-abbr
znap source MichaelAquilina/zsh-you-should-use
znap source marlonrichert/zsh-autocomplete


# znap source go-task/task lib/completion/zsh/_task

# `znap eval` makes evaluating generated command output up to 10 times faster.
znap eval iterm2 'curl -fsSL https://iterm2.com/shell_integration/zsh'

# zstyle ':autocomplete:*' default-context history-incremental-search-backward

#  Vars and Paths
export PATH=/Users/vucinjo/.bin:$PATH
export PATH="$HOME/dotfiles/bin:$PATH"
# pip dir
export PATH=$PATH:/usr/local/bin
export ERL_AFLAGS="-kernel shell_history enabled" # enable history in iex
export PATH="$HOME/dotfiles/bin:$PATH"
export EDITOR="nvim"
export TERM=xterm-256color
# export TERM=screen-256color
export COLORTERM='24bit'
# export TERM=wezterm
# export TERM=xterm-kitty
export FZF_DEFAULT_OPTS='--preview "pygmentize {}" --color dark --bind "?:toggle-preview" --preview-window "right:50%:hidden"'
export DISABLE_AUTO_TITLE='true'


export DISABLE_AUTO_TITLE='true'
export ZK_NOTEBOOK_DIR='/Users/vucinjo/Dropbox/Notes'
# nvim and lazygit
# export NVIM_LISTEN_ADDRESS=/tmp/nvim-$(basename $PWD)
export NVIM_LISTEN_ADDRESS=/tmp/nvim.pipe

dstats() { docker stats --all --format "table {{.ID}}\t{{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}" }
dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }

delete_snapshots() {
  for d in $(tmutil listlocalsnapshotdates | grep "-"); do sudo tmutil deletelocalsnapshots $d; done
}

# Fixes
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=#666666 # in neovim terminal auto suggestions not visible

#  Custom func's
#  lsof -t -i tcp:3000 | xargs kill
kill_port() {
  readonly port=${1:?"The port must be specified."}

  # lsof -i tcp:"$port" | grep LISTEN | awk '{print $2}' | xargs kill
  echo $(lsof -t -i:${port})
  kill -9 $(lsof -t -i:${port})
}

if command -v go &> /dev/null
then
  export PATH=${PATH}:`go env GOPATH`/bin
fi

if command -v zoxide &> /dev/null
then
 eval "$(zoxide init zsh)"
fi

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# Golang
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# alias t="topydo columns"
export TODOTXT_CFG_FILE=$HOME/.config/todo.txt-cli/conf.cfg
source /opt/homebrew/etc/bash_completion.d/todo_completion complete -F _todo t
alias t="/opt/homebrew/bin/todo.sh"
alias nvim='nvim --listen /tmp/nvim-server.pipe'
