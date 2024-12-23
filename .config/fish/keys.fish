bind --preset \cy yank
bind --preset \ey yank-pop
bind --preset -k right forward-char
bind --preset -k left backward-char
bind --preset \e\[C forward-char
bind --preset \e\[D backward-char
bind --preset \c\[1\;5C forward-word
bind --preset \c\[1\;5D backward-word
bind --preset -k ppage beginning-of-history
bind --preset -k npage end-of-history
bind --preset \cx fish_clipboard_copy
bind --preset \cv fish_clipboard_paste
bind --preset \e cancel
bind --preset \t complete
bind --preset \cs pager-toggle-search
bind --preset -k btab complete-and-search
bind --preset -k sdc history-pager-delete or backward-delete-char
bind --preset \e\n commandline\ -f\ expand-abbr\;\ commandline\ -i\ \\n
bind --preset \e\r commandline\ -f\ expand-abbr\;\ commandline\ -i\ \\n
bind --preset -k down down-or-search
bind --preset -k up up-or-search
bind --preset \e\[A up-or-search
bind --preset \e\[B down-or-search
bind --preset -k sright forward-bigword
bind --preset -k sleft backward-bigword
bind --preset \e\eOC nextd-or-forward-word
bind --preset \e\eOD prevd-or-backward-word
bind --preset \e\e\[C nextd-or-forward-word
bind --preset \e\e\[D prevd-or-backward-word
bind --preset \eO3C nextd-or-forward-word
bind --preset \eO3D prevd-or-backward-word
bind --preset \e\[3C nextd-or-forward-word
bind --preset \e\[3D prevd-or-backward-word
bind --preset \e\[1\;3C nextd-or-forward-word
bind --preset \e\[1\;3D prevd-or-backward-word
bind --preset \e\[1\;9C nextd-or-forward-word
bind --preset \e\[1\;9D prevd-or-backward-word
bind --preset \e\eOA history-token-search-backward
bind --preset \e\eOB history-token-search-forward
bind --preset \e\e\[A history-token-search-backward
bind --preset \e\e\[B history-token-search-forward
bind --preset \eO3A history-token-search-backward
bind --preset \eO3B history-token-search-forward
bind --preset \e\[3A history-token-search-backward
bind --preset \e\[3B history-token-search-forward
bind --preset \e\[1\;3A history-token-search-backward
bind --preset \e\[1\;3B history-token-search-forward
bind --preset \e\[1\;9A history-token-search-backward
bind --preset \e\[1\;9B history-token-search-forward
bind --preset \e. history-token-search-backward
bind --preset \el __fish_list_current_token
bind --preset \eo __fish_preview_current_file
bind --preset \ew __fish_whatis_current_token
bind --preset \cl clear-screen
bind --preset \cc cancel-commandline
bind --preset \cu backward-kill-line
bind --preset \cw backward-kill-path-component
bind --preset \e\[F end-of-line
bind --preset \e\[H beginning-of-line
bind --preset \ed kill-word
bind --preset \cd delete-or-exit
bind --preset \es 'for cmd in sudo doas please; if command -q $cmd; fish_commandline_prepend $cmd; break; end; end'
bind --preset -k f1 __fish_man_page
bind --preset \eh __fish_man_page
bind --preset \ep __fish_paginate
bind --preset \e\# __fish_toggle_comment_commandline
bind --preset \ee edit_command_buffer
bind --preset \ev edit_command_buffer
bind --preset \e\[I 'emit fish_focus_in'
bind --preset \e\[O false
bind --preset \e\[\?1004h false
bind --preset -M insert \e\[I 'emit fish_focus_in'
bind --preset -M insert \e\[O false
bind --preset -M insert \e\[\?1004h false
bind --preset -m paste \e\[200\~ __fish_start_bracketed_paste
bind --preset -M insert -m paste \e\[200\~ __fish_start_bracketed_paste
bind --preset -M paste \e\[201\~ __fish_stop_bracketed_paste
bind --preset -M paste '' self-insert
bind --preset -M paste \r commandline\ -i\ \\n
bind --preset -M paste \' __fish_commandline_insert_escaped\ \\\'\ \$__fish_paste_quoted
bind --preset -M paste \\ __fish_commandline_insert_escaped\ \\\\\ \$__fish_paste_quoted
bind --preset -M paste ' ' self-insert-notfirst
bind --preset '' self-insert
bind --preset ' ' self-insert expand-abbr
bind --preset ';' self-insert expand-abbr
bind --preset '|' self-insert expand-abbr
bind --preset '&' self-insert expand-abbr
bind --preset '>' self-insert expand-abbr
bind --preset '<' self-insert expand-abbr
bind --preset ')' self-insert expand-abbr
bind --preset -k nul 'test -n "$(commandline)" && commandline -i " "'
bind --preset \e\[32\;2u 'commandline -i " "; commandline -f expand-abbr'
bind --preset \n execute
bind --preset \r execute
bind --preset \e\[27\;5\;13\~ execute
bind --preset \e\[13\;5u execute
bind --preset \e\[27\;2\;13\~ execute
bind --preset \e\[13\;2u execute
bind --preset \ck kill-line
bind --preset -k dc delete-char
bind --preset -k backspace backward-delete-char
bind --preset \e\[1\~ beginning-of-line
bind --preset \e\[4\~ end-of-line
bind --preset -k home beginning-of-line
bind --preset -k end end-of-line
bind --preset \ca beginning-of-line
bind --preset \ce end-of-line
bind --preset \b backward-delete-char
bind --preset \cp up-or-search
bind --preset \cn down-or-search
bind --preset \cf forward-char
bind --preset \cb backward-char
bind --preset \ct transpose-chars
bind --preset \cg cancel
bind --preset \x1f undo
bind --preset \cz undo
bind --preset \e/ redo
bind --preset \et transpose-words
bind --preset \eu upcase-word
bind --preset \ec capitalize-word
bind --preset \e\x7f backward-kill-word
bind --preset \e\b backward-kill-word
bind --preset \eb backward-word
bind --preset \ef forward-word
bind --preset \e\< beginning-of-buffer
bind --preset \e\> end-of-buffer
bind --preset \cr history-pager
bind --preset \e\ ep fish_clipboard_paste
bind \cr fzf-history-widget
bind \ct fzf-file-widget
bind \ec fzf-cd-widget
bind -M insert \cr fzf-history-widget
bind -M insert \ct fzf-file-widget
bind -M insert \ec fzf-cd-widget
bind \r _tide_enter_transient
bind \n _tide_enter_transient
bind -M insert \r _tide_enter_transient
bind -M insert \n _tide_enter_transient
