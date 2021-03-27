#!/usr/bin/env fish

# Custom environment variables
set -x XDG_CONFIG_HOME $HOME/.config
set -g REPOS_HOME $HOME/repos 
set -g REPOS_PUBLIC $REPOS_HOME/public
set -g REPOS_PRIVATE $REPOS_HOME/private
set -g CONFIG_FISH $XDG_CONFIG_HOME/fish
set fish_config_home $XDG_CONFIG_HOME/fish

source $fish_config_home/aliases.fish
# enable general colors in 'less'
set -x LESS "$LESS -R -Q"
# enable syntax highlighting in 'less'
set -x LESSOPEN "| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"

fish_vi_key_bindings

set fish_color_cwd B27AFF

set -g display_hostname
set -g display_user
set -g theme_color_scheme dark
set -g theme_display_docker_machine yes
set -g theme_display_user fish-shell
set -g theme_nerd_fonts yes
set -g theme_powerline_fonts no


set PATH $PATH /home/john/.tools

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/john/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

