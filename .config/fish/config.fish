set -gx EDITOR nvim
set -g VISUAL nvim
set -gx TERMINAL wezterm
set -gx PAGER nvimpager
set PATH $PATH /home/anton/.local/bin /home/anton/.cargo/bin
set -g GOPATH /home/anton/.local

abbr -a lg lazygit
abbr -a s systemctl
abbr -a c config
abbr -a ca config add
abbr -a np nvimpager
abbr -a n nvim

bind --erase --all
source ~/.config/fish/keys.fish

zoxide init fish --cmd cd | source
fzf --fish | source
