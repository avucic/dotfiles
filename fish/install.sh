set -e

if ! command -v starship &>/dev/null; then
    mkdir -p $HOME/.config
    ln -sf "${DOTFILES_LOCATION}/fish/config.fish" "${HOME}/.config/fish/config.fish"
fi
