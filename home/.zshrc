#  Setup  --------------------------------------------------------------------{{{
export ANTIGEN=/usr/local/share/antigen
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
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome  --args --disable-web-security &"
alias n='TERM=xterm-256color nvim'
alias r='rails'
alias rk='rake'
alias cl='clear'
alias t='tmux'
alias ta='tmux a -t'
alias tn='tmux new -s'
alias f='fzf'
alias tmux="TERM=xterm-256color tmux -2"
# }}}
#  Vars and Paths  -----------------------------------------------------------{{{
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin

# Brew {{{
homebrew=/usr/local/bin:/usr/local/sbin
export PATH=$homebrew:$PATH
# }}}

# Rbenv {{{
eval "$(rbenv init - --no-rehash)"
rbenv-clean(){gem list | cut -d" " -f1 | xargs gem uninstall -aIx}
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
export NODE_PATH=/usr/local/lib/node_modules
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
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
# }}}

# FZF {{{
export FZF_DEFAULT_OPTS='--preview "pygmentize {}" --color dark --bind "?:toggle-preview" --preview-window "right:50%:hidden"'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# }}}
# }}}
