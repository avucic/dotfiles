# system-wide environment settings for zsh(1)
if [ -x /usr/libexec/path_helper ]; then
	eval `/usr/libexec/path_helper -s`
fi

# vim mode
bindkey -v
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"


# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse )
plugins=(rails git textmate ruby alex osx zsh-syntax-highlighting git-flow pyenv)

source $ZSH/oh-my-zsh.sh
# Customize to your needs...
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin

homebrew=/usr/local/bin:/usr/local/sbin
export PATH=$homebrew:$PATH

rbenv-clean(){gem list | cut -d" " -f1 | xargs gem uninstall -aIx}

# export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
export PATH="$HOME/dotfiles/bin:$PATH"

### PG
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin
alias FIX_PG="declare -x PGDATA='/Users/vucinjo/Library/Application Support/Postgres/var-9.4' && pg_ctl restart -m immediate"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
export MAIL_INTERCEPTOR_EMAIL="contact@vucicaleksandar.com"
export GNUTERM=x11
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export NODE_PATH=/usr/local/lib/node_modules
export TERM="xterm-256color"

alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome  --args --disable-web-security &"
alias n='TERM=xterm-256color nvim'
alias r='rails'
alias rk='rake'
alias cl='clear'
alias t='tmux'
alias ta='tmux a -t'
alias tn='tmux new -s'
# alias tmux="TERM=screen-256color-bce tmux"
alias tmux="TERM=xterm-256color tmux -2"

# alias vim='/usr/local/Cellar/macvim/7.4-76/MacVim.app/Contents/MacOS/Vim'
export DISABLE_AUTO_TITLE=true

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - --no-rehash)"
##
## Android SDK
##
export ANDROID_SDK=/usr/local/Cellar/android-sdk/
export PATH=$PATH:/Users/vucinjo/Library/Android/sdk/ndk-bundle
export PATH=$PATH:~/Library/Android/sdk/platform-tools

##
## Python
##
# export PATH="$HOME/Library/Python/3.6/bin:$PATH"

# export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
# export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
# export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
#
# source /usr/local/Cellar/python3/3.6.1/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh
# source /usr/local/bin/virtualenvwrapper.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

source /Users/vucinjo/.pyenv/versions/3.6.4/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh
