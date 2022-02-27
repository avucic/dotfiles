if status is-interactive
    # Commands to run in interactive sessions can go here
    set -l onedark_options -b

    if set -q VIM
        # Using from vim/neovim.
        set onedark_options -256
    else if string match -iq "eterm*" $TERM
        # Using from emacs.
        function fish_title
            true
        end
        set onedark_options -256
    end

    set_onedark $onedark_options

    starship init fish | source

    source ~/autojump/bin/autojump.fish
    source ~/dotfiles/shell/aliases.sh
end
