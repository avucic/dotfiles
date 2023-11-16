export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# source ~/.env
# source "${HOME}/.zgen/zgen.zsh"
#
# # if the init script doesn't exist
# if ! zgen saved; then
#
#   # specify plugins here
#   zgen oh-my-zsh
#
#   zgen oh-my-zsh plugins/git
#   zgen oh-my-zsh plugins/sudo
#   zgen oh-my-zsh plugins/command-not-found
#   zgen oh-my-zsh plugins/docker
#   # zgen oh-my-zsh plugins/rails
#   zgen oh-my-zsh plugins/brew
#   zgen oh-my-zsh plugins/asdf
#   zgen oh-my-zsh plugins/ruby
#   zgen oh-my-zsh plugins/autojump
#   zgen oh-my-zsh plugins/direnv
#   zgen oh-my-zsh plugins/rust
#
#   zgen load zsh-users/zsh-syntax-highlighting
#   zgen load zsh-users/zsh-completions
#   zgen load zsh-users/zsh-autosuggestions
#   zgen load svenXY/timewarrior
#   zgen load spaceship-prompt/spaceship-prompt
#   zgen load olets/zsh-abbr
#   zgen load MichaelAquilina/zsh-you-should-use
#   zgen load marlonrichert/zsh-autocomplete
#
#   # workadround
#   zgen load ~/.zgen/olets/zsh-abbr-main/zsh-abbr.plugin.zsh
#
#   # generate the init script from plugins above
#   zgen save
# fi

[[ -r ~/.znap/znap.zsh ]] ||
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git ~/.znap

source ~/.znap/znap.zsh

zstyle ':znap:*' repos-dir ~/.znap/custom

if command -v direnv &>/dev/null; then
  eval "$(direnv hook zsh)"
fi

# `znap prompt` makes your prompt visible in just 15-40ms!
znap prompt sindresorhus/pure

znap source avucic/ohmyzsh \
  lib/{git,grep,history,key-bindings,completion} \
  plugins/git \
  plugins/colored-man-pages \
  plugins/docker-compose \
  plugins/asdf \
  plugins/autojump \
  plugins/direnv \
  plugins/ruby \
  plugins/rake \
  plugins/asdf \
  plugins/exa-zsh \
  plugins/tmux

#TODO:
# fix rust plugins/rust \
# plugins/docker \

# `znap source` starts plugins.
znap source zsh-users/zsh-syntax-highlighting
znap source zsh-users/zsh-completions
znap source zsh-users/zsh-autosuggestions
znap source svenXY/timewarrior
znap source olets/zsh-abbr
znap source MichaelAquilina/zsh-you-should-use
znap source marlonrichert/zsh-autocomplete

# zstyle ':autocomplete:*' default-context history-incremental-search-backward

#  Vars and Paths
export PATH=/Users/vucinjo/bin:$PATH
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

# if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
#     alias nvim=nvr --servername $NVIM_LISTEN_ADDRESS --nostart -cc split --remote-wait +'set bufhidden=wipe'
# fi
#
# # Run
# # alias du="docker-compose up"
# # Stop all containers
# dstop() { docker stop $(docker ps -a -q); }
# # Remove all containers
# drm() { docker rm $(docker ps -a -q); }
# # Stop and Remove all containers
# # Remove all images
# dri() { docker rmi $(docker images -q); }
# drni() { docker rmi $(docker images | grep none | awk '{print $3}') }
# # clean volumes
# drv() { docker volume rm $(docker volume ls -qf dangling=true); }
# # Dockerfile build, e.g., $dbu tcnksm/test
# dbu() { docker build -t=$1 .; }
# # Show all alias related docker
# dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }
# # Bash into running container
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


# Taskwarrior
alias in='task add'
onday () {
    deadline=$1
    shift
    in +onday wait:$deadline $@
}

read_and_review (){
    link="$1"
    title=$(wget -qO- $link | perl -l -0777 -ne 'print $1 if /<title.*?>\s*(.*?)\s*<\/title/si')
    echo $title
    descr="\"Read and review: $title\""
    id=$(task add +review "$descr" | sed -n 's/Created task \(.*\)./\1/p')
    task "$id" annotate "$link"
}

function zr () { zellij run --name "$*" -- zsh -ic "$*";}
function zrf () { zellij run --name "$*" --floating -- zsh -ic "$*";}
function ze () { zellij edit "$*";}
function zef () { zellij edit --floating "$*";}


alias rnr=read_and_review
