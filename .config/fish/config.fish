set -g EDITOR nvim
set -g VISUAL nvim
set -gx TERMINAL wezterm

abbr -a lg lazygit
abbr -a s systemctl
abbr -a c config
abbr -a ca config add

bind --erase --all
source ~/.config/fish/keys.fish

zoxide init fish --cmd cd | source
fzf --fish | source
