function set_custom_keys
    bind --erase --all

    bind right forward-char
    bind left backward-char
    bind ctrl-right forward-word
    bind ctrl-left backward-word
    bind tab complete
    bind ctrl-s pager-toggle-search
    bind up up-or-search
    bind down down-or-search
    bind ctrl-l clear-screen
    bind ctrl-c cancel-commandline
    bind ctrl-w backward-kill-path-component
    bind home end-of-line
    bind end beginning-of-line
    bind ctrl-S 'fish_commandline_prepend sudo'
    bind ctrl-N edit_command_buffer
    bind '' self-insert
    bind ' ' self-insert expand-abbr
    bind ';' self-insert expand-abbr
    bind '|' self-insert expand-abbr
    bind '&' self-insert expand-abbr
    bind '>' self-insert expand-abbr
    bind '<' self-insert expand-abbr
    bind ')' self-insert expand-abbr
    bind enter execute
    bind ctrl-k kill-line
    bind ctrl-a beginning-of-line
    bind ctrl-e end-of-line
    bind backspace backward-delete-char
    bind ctrl-p up-or-search
    bind ctrl-n down-or-search
    bind ctrl-f forward-char
    bind ctrl-b backward-char
    bind ctrl-T transpose-words
    bind ctrl-g cancel
    bind ctrl-z undo
    bind ctrl-u capitalize-word
    bind ctrl-U upcase-word
    bind ctrl-backspace backward-kill-word
    bind ctrl-h backward-kill-word
    bind ctrl-r fzf-history-widget
    bind ctrl-t fzf-file-widget
    bind ctrl-d fzf-cd-widget
    bind enter _tide_enter_transient
    bind \n _tide_enter_transient
end
