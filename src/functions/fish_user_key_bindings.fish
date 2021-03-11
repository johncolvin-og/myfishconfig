#!/usr/bin/env fish

source /home/john/.config/fish/aliases.fish
# make less more friendly for non-text input files, see lesspipe(1)
# [ -x /usr/bin/lesspipe ] && eval '(SHELL=/bin/sh lesspipe)'
# enable general colors in 'less'
set -x LESS "$LESS -R -Q"
# enable syntax highlighting in 'less' 
set -x LESSOPEN "| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"

set -x XDG_CONFIG_HOME $HOME"/.config"
set -g theme_powerline_fonts no
set -g theme_nerd_fonts yes
fish_vi_key_bindings
#set fish_color_cwd A25AE2
set fish_color_cwd B27AFF

#bind \cy accept-autosuggestion
#bind \t forward-word
bind -M insert \cn down-or-search
bind -M insert \cp up-or-search
bind -M insert \cj down-or-search
bind -M insert \ck up-or-search
bind -M insert \cl forward-char
bind -M insert \ch backward-char
bind -M insert \cH backward-bigword
set -x LS_COLORS "$LS_COLORS:di=38;5;141;48;5;234:fi=94:*.h=38;5;039:*.cpp=38;5;024:*.py=38;5;041:*.txt=38;5;251"
set PATH $PATH /home/john/.tools/
bind -M default \cv 'set fish_bind_mode default'
bind -M default \e 'set fish_bind_mode default'

