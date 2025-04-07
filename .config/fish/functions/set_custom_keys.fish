function set_custom_keys
    bind --erase --all

    bind right forward-char
    bind left backward-char
    bind ctrl-right forward-word
    bind ctrl-left backward-word
    bind tab complete
    bind shift-tab complete-and-search
    bind ctrl-f pager-toggle-search
    bind up up-or-search
    bind down down-or-search
    bind ctrl-l clear-screen
    bind ctrl-c clear-commandline
    bind ctrl-w backward-kill-path-component
    bind home end-of-line
    bind end beginning-of-line
    bind ctrl-s 'fish_commandline_prepend sudo' repaint
    bind ctrl-n edit_command_buffer
    bind '' self-insert
    bind ' ' self-insert expand-abbr
    bind ';' self-insert expand-abbr
    bind '|' self-insert expand-abbr
    bind '&' self-insert expand-abbr
    bind '>' self-insert expand-abbr
    bind '<' self-insert expand-abbr
    bind ')' self-insert expand-abbr
    bind ctrl-k kill-line
    bind ctrl-b beginning-of-line
    bind ctrl-e end-of-line
    bind backspace backward-delete-char
    bind ctrl-backspace backward-kill-word
    bind ctrl-r fzf-history-widget
    bind ctrl-t fzf-file-widget
    bind ctrl-d fzf-cd-widget
    bind ctrl-^ 'fish_commandline_append " &>/dev/null &"' execute
    bind enter transient_execute
end
