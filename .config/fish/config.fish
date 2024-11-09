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

# Created by `pipx` on 2024-11-09 12:11:28
set PATH $PATH /home/anton/.local/bin
