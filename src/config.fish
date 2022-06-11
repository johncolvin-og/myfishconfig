#!/usr/bin/env fish

set -x XDG_CONFIG_HOME $HOME/.config
set fish_config_home $XDG_CONFIG_HOME/fish
source $fish_config_home/aliases.fish
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
set fish_color_command F8F8F2

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

source $fish_config_home/functions/johncolvin_profiles.fish
set_profile_titan

# Custom environment variables
set -g REPOS $HOME/Documents/repos
set -g REPOS_PUBLIC $REPOS/public
set -g REPOS_PRIVATE $REPOS/private
set -g CONFIG_FISH $XDG_CONFIG_HOME/fish
set -g VIRTUAL_ENV_DISABLE_PROMPT true

set PATH $PATH /home/$USER/.tools

function get_existing_path -d "Echos a path if it exists, otherwise returns 1"
    if test -f $argv[1]
        echo $argv[1]
    else
        return 1
    end
end

function try_append_to_path -d "Appends a path to the PATH variable if it exists"
   if test -e $argv[1]
      set PATH $PATH $argv[1]
   end
end

try_append_to_path /home/$USER/.tools
try_append_to_path /home/$USER/go/bin


set maybe_conda_path (which conda; or\
    get_existing_path "/home/$USER/anaconda3/condabin/conda"; or\
    get_existing_path "/home/$USER/anaconda3/bin/conda")
if test $status = 0; and test -f $maybe_conda_path
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    eval $maybe_conda_path "shell.fish" "hook" $argv | source
    # <<< conda initialize <<<
end
