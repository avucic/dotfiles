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

plugins=(
    git
    brew
    yarn
    golang
    ruby
    rails
    rake
    asdf
)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if command -v direnv &>/dev/null; then
  eval "$(direnv hook zsh)"
fi

#  Vars and Paths
export PATH=/Users/vucinjo/bin:$PATH
export ERL_AFLAGS="-kernel shell_history enabled" # enable history in iex
export PATH="$HOME/dotfiles/bin:$PATH"
export EDITOR="code"
export TERM=xterm-256color
export FZF_DEFAULT_OPTS='--preview "pygmentize {}" --color dark --bind "?:toggle-preview" --preview-window "right:50%:hidden"'

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

clean_mac_snapshots() {
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