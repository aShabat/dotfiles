set -g EDITOR nvim
set -g VISUAL nvim
set -gx TERMINAL wezterm

abbr -a lg lazygit
abbr -a s systemctl
abbr -a c config

zoxide init fish --cmd cd | source
fzf --fish | source
