set -e

if ! command -v starship &>/dev/null; then
    # sh -c "$(curl -fsSL https://starship.rs/install.sh)"
    yes Y | curl -fsSL https://starship.rs/install.sh
    mkdir -p $HOME/.config
    ln -sf "${DOTFILES_LOCATION}/starship/starship.toml" "${HOME}/.config/starship.toml"
fi
