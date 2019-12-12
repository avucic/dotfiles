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
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome  --args --disable-web-security --remote-debugging-port=9222 &"
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
# clean volumes
drv() { docker volume rm $(docker volume ls -qf dangling=true); }
# Dockerfile build, e.g., $dbu tcnksm/test
dbu() { docker build -t=$1 .; }
# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }
# Bash into running container
dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }
alias d='docker'


alias dclimate="docker run \
  --interactive --tty --rm \
  --env CODECLIMATE_CODE="$PWD" \
  --volume "$PWD":/code \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume /tmp/cc:/tmp/cc \
  codeclimate/codeclimate analyze $1"


# }}}
#  Vars and Paths  -----------------------------------------------------------{{{
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin
export PATH=/root/bin:$PATH

# Brew {{{
homebrew=/usr/local/bin:/usr/local/sbin
export PATH=$homebrew:$PATH
# }}}

# Rbenv {{{
if command -v rbenv 1>/dev/null 2>&1; then
  eval "$(rbenv init - --no-rehash)"
  rbenv-clean(){gem list | cut -d" " -f1 | xargs gem uninstall -aIx}
fi
# }}}

# Tmux & Nvim {{{
# export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
export PATH="$HOME/dotfiles/bin:$PATH"
# }}}

# PG {{{
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin
alias FIX_PG="declare -x PGDATA='/Users/vucinjo/Library/Application Support/Postgres/var-9.4' && pg_ctl restart -m immediate"
#}}}

# Heroku Toolbelt {{{
export PATH="/usr/local/heroku/bin:$PATH"
export MAIL_INTERCEPTOR_EMAIL="contact@vucicaleksandar.com"
export GNUTERM=x11
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
# export NODE_PATH=/usr/local/lib/node_modules
# export NODE_PATH=$NODE_PATH:`nvm which default `
export TERM="xterm-256color"
export DISABLE_AUTO_TITLE=true
export PATH="$HOME/.rbenv/bin:$PATH"
#}}}

# Android SDK {{{
export ANDROID_SDK=/usr/local/Cellar/android-sdk/
export PATH=$PATH:/Users/vucinjo/Library/Android/sdk/ndk-bundle
export PATH=$PATH:~/Library/Android/sdk/platform-tools
#}}}

# Python {{{
if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$(pyenv root)"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi
# }}}

# FZF {{{
export FZF_DEFAULT_OPTS='--preview "pygmentize {}" --color dark --bind "?:toggle-preview" --preview-window "right:50%:hidden"'
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# }}}
# NVM {{{
# # NVM
export NVM_DIR=~/.nvm
if command -v brew 1>/dev/null 2>&1; then
  source $(brew --prefix nvm)/nvm.sh
fi
# }}}
# VSCode {{{
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
# function c {
#     if [[ $# = 0 ]]
#     then
#         open -a "Visual Studio Code"
#     else
#         local argPath="$1"
#         [[ $1 = /* ]] && argPath="$1" || argPath="$PWD/${1#./}"
#         open -a "Visual Studio Code" "$argPath"
#     fi
# }
# }}}
# flutter and dart {{{
export PATH="$PATH:/Users/vucinjo/sdk/flutter/bin"
export PATH="$PATH":"$HOME/.pub-cache/bin"
# }}}
