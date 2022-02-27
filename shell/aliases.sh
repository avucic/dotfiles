# alias e=emacs
# alias em=emacs --deamon
# export ALTERNATE_EDITOR=""
# alias e=emacsclient --create-frame -a '' -c
# alias ed="emacs --daemon="
# alias e="emacsclient --create-frame -n"
alias et="TERM=xterm-24bit emacsclient -a '' -c" #spacemacs terminal client
alias e="emacs" # spacemacs gui client
export ALTERNATE_EDITOR='' # for emacs deamon
export ALTERNATE_EDITOR=""
export EDITOR="emacs"

alias n='TERM=xterm-24bit nvim'
alias r='rails'
alias rk='rake'
alias cl='clear'
alias t='tmux'
alias ta='tmux a -t'
alias tk='tmux kill-session -t'
alias tka='tmux kill-server'
alias tn='tmux new -s'
alias f='fzf'
alias tmux="TERM=xterm-24bit tmux -2"

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
# alias du="docker-compose up"
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

alias dclimate="docker run \
  --interactive --tty --rm \
  --env CODECLIMATE_CODE="$PWD" \
  --volume "$PWD":/code \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume /tmp/cc:/tmp/cc \
  codeclimate/codeclimate analyze $1"
