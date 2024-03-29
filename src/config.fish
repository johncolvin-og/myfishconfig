#!/usr/bin/env fish

function _try_source --description "Runs 'source' on file if it exists"
    if test -e $argv[1]
        source $argv
    end
end

if not set -q XDG_CONFIG_HOME
    set -x XDG_CONFIG_HOME $HOME/.config
end

set fish_config_home $XDG_CONFIG_HOME/fish
_try_source $fish_config_home/aliases.fish

# enable general colors and case insensitive search in 'less'
set -x LESS "$LESS -R -Q -I"
set -x LC_ALL en_US.UTF-8
# enable syntax highlighting in 'less'
set -x LESSOPEN "| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
# set highlight color scheme in 'less' (fg)(bg)
set -g LESS_TERMCAP_md (tput bold)(tput setaf 36)
set -g LESS_TERMCAP_me (tput sgr0)
set -g LESS_TERMCAP_so (tput setaf 232)(tput setab 49)

set -q TERM
if test $status != 0; or test $TERM = 'xterm'
    set -g TERM 'xterm-256color'
end

fish_vi_key_bindings

# Fix impossible-to-see navy blue command text color
set -g fish_color_command F8F8F2
set -g display_hostname
set -g display_user
set -g theme_color_scheme dark
set -g theme_display_docker_machine yes
set -g theme_display_user fish-shell
set -g theme_nerd_fonts yes
set -g theme_powerline_fonts no

set -g left_pwd_style short
set -g budspencer_pwdstyle git none none
set -g budspencer_display_user
# Custom environment variables
set -g REPOS $HOME/Documents/repos

if _try_source $fish_config_home/functions/johncolvin_profiles.fish
    set_profile_titan
end

if _try_source $fish_config_home/functions/append-to-path.fish
    append-to-path /home/$USER/.tools
    append-to-path /home/$USER/go/bin
end

set maybe_conda_path (which conda)
if test $status -ne 0; and _try_source $fish_config_home/functions/get-existing-path.fish
    set maybe_conda_path (which conda; or\
        get-existing-path "/home/$USER/anaconda3/condabin/conda"; or\
        get-existing-path "/home/$USER/anaconda3/bin/conda")
end

if test -f "$maybe_conda_path"
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    eval $maybe_conda_path "shell.fish" "hook" $argv | source
    # <<< conda initialize <<<
end
