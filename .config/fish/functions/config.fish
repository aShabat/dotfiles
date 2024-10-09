function config
    if test ( count $argv) -eq 0
        lazygit -g=$HOME/.config/dotfiles.git/ -w=$HOME
    else
        git --git-dir=$HOME/.config/dotfiles.git/ --work-tree=$HOME $argv
    end
end
