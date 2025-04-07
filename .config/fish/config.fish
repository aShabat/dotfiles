fish_add_path -a /home/anton/.local/bin /home/anton/.cargo/bin /home/anton/.local/go/bin

abbr -a lg lazygit
abbr -a s systemctl
abbr -a c config
abbr -a ca config add
abbr -a np nvimpager
abbr -a n nvim
abbr -a cpp g++ -std=c++17 -ggdb -pedantic-errors -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion -Werror

abbr -a o xdg-open
abbr -a open xdg-open

abbr -a snapl sudo snapper list -a --disable-used-space
abbr -a snapls sudo snapper list -a

set -g fish_key_bindings set_custom_keys
