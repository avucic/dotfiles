#  Setup  --------------------------------------------------------------------{{{
export ANTIGEN=$HOME
# If there is cache available
if [[ -f ${ADOTDIR:-$HOME/.antigen}/.cache/.zcache-payload ]]; then
    # Load bundles statically
    source ${ADOTDIR:-$HOME/.antigen}/.cache/.zcache-payload

    You will need to call compinit
    autoload -Uz compinit
    compinit -d ${HOME}/.zcompdump
else
    # If there is no cache available do load and execute antigen
    source $ANTIGEN/antigen.zsh

    # I'm using antigen-init here but your usual antigen-bundle,
    # antigen-theme, antigen-apply will work as well
    antigen init $HOME/.antigenrc
fi
# }}}
#  Aliases  ------------------------------------------------------------------{{{
alias e=emacs
alias n='TERM=xterm-256color nvim'
alias r='rails'
alias rk='rake'
alias cl='clear'
alias t='tmux'
alias ta='tmux a -t'
alias tk='tmux kill-session -t'
alias tka='tmux kill-server'
alias tn='tmux new -s'
alias f='fzf'
alias tmux="TERM=xterm-256color tmux -2"

# ------------------------------------
# Docker alias and function
# ------------------------------------

alias dc="docker-compose"
alias dr="docker-compose run"
# Get latest container ID
alias dl="docker ps -l -q"
# Get container process
alias dps="docker ps"
# Get process included stop container
alias dpa="docker ps -a"
# Get images
alias di="docker images"
# attach process
alias da="docker attach"
# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"
# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -i -t -P"
# Execute interactive container, e.g., $dex base /bin/bash
alias dex="docker exec -i -t"
# Run
alias du="docker-compose up"
# Stop all containers
dstop() { docker stop $(docker ps -a -q); }
# Remove all containers
drm() { docker rm $(docker ps -a -q); }
# Stop and Remove all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'
alias dsa='docker stop $(docker ps -a -q)'
alias dse='docker rm -v $(docker ps -a -q -f status=exited)'
# Remove all images
dri() { docker rmi $(docker images -q); }
drni() { docker rmi $(docker images | grep none | awk '{print $3}') }
# clean volumes
drv() { docker volume rm $(docker volume ls -qf dangling=true); }
# Dockerfile build, e.g., $dbu tcnksm/test
dbu() { docker build -t=$1 .; }
# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }
# Bash into running container
dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }
dstats() { docker stats --all --format "table {{.ID}}\t{{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}" }
alias d='docker'

#  lsof -t -i tcp:3000 | xargs kill
kill_port() {
    readonly port=${1:?"The port must be specified."}

    # lsof -i tcp:"$port" | grep LISTEN | awk '{print $2}' | xargs kill
    echo $(lsof -t -i:${port})
    kill -9 $(lsof -t -i:${port})
}


alias dclimate="docker run \
  --interactive --tty --rm \
  --env CODECLIMATE_CODE="$PWD" \
  --volume "$PWD":/code \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume /tmp/cc:/tmp/cc \
  codeclimate/codeclimate analyze $1"


# }}}
#  Vars and Paths  -----------------------------------------------------------{{{
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:$PATH
export ERL_AFLAGS="-kernel shell_history enabled" # enable history in iex
# Dotfiles bin {{{
export PATH="$HOME/dotfiles/bin:$PATH"
# }}}

# FZF {{{
export FZF_DEFAULT_OPTS='--preview "pygmentize {}" --color dark --bind "?:toggle-preview" --preview-window "right:50%:hidden"'
# export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# }}}

# rbenv {{{
# if [[ -x $HOME/.rbenv ]]
# then
#   export PATH="$HOME/.rbenv/bin:$PATH"
#   eval "$(rbenv init - zsh)"
# fi
# }}}

# alias loadnvm='[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"'

# # MAC {{{
# if [[ $(uname -s) == Darwin ]]
# then
#   clrsnaps(){ for d in $(tmutil listlocalsnapshotdates | grep "-"); do sudo tmutil deletelocalsnapshots $d; done }
#   [[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh  # This loads NVM
# fi
# # }}}

# Direnv {{{
  echo "loading direnv"
  eval "$(direnv hook zsh)"
# }}}

# NVM {{{
# alias loadnvm='[ -s "$HOME/.nvm/nvm.sh" ] && . "$HOME/.nvm/nvm.sh"'
# }}}

# Brew {{{
alias brewski='brew update && brew upgrade && brew cleanup; brew doctor'
export PATH="/usr/local/sbin:$PATH"
# }}}

#  export NVM_DIR=~/.nvm
#  source $(brew --prefix nvm)/nvm.sh
. $(brew --prefix asdf)/asdf.sh

# Utils {{{
  clean_mac_snapshots(){
    for d in $(tmutil listlocalsnapshotdates | grep "-"); do sudo tmutil deletelocalsnapshots $d; done
  }
# }}}


# Fixes {{{
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=#666666 # in neovim terminal auto suggestions not visible
# }}}
