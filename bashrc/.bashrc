[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# unset ASDF_DIR
# source $(brew --prefix asdf)/libexec/asdf.sh
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    alias nvim=nvr -cc split --remote-wait +'set bufhidden=wipe'
fi

export NVIM_LISTEN_ADDRESS=/tmp/nvim-$(basename $PWD)
. "$HOME/.cargo/env"
