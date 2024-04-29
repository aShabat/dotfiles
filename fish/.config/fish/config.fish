if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g EDITOR nvim
set -g VISUAL nvim

abbr --add lg lazygit

zoxide init fish --cmd cd | source
