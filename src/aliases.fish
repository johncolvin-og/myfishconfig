#!/usr/bin/env fish

function grepi -d "grep w/ common flags"
    grep -rnHIi $argv
end

function grepic -d "grep w/ common flags and colored output"
    grep -rnHIi --color=always $argv
end

function grepicl --description "grep w/ common flags and colored output (piped to 'less')"
    grep -rnHIi --color=always $argv | less +F
end

function lessq -d "less pager fit to screen"
   less --quit-if-one-screen $argv
end

function l --description "List contents of directory using long format"
   ls -lh $argv
end

function ld --description "List contents of directory using long format (group directories first)"
   ls -lh --group-directories-first $argv
end

function ll -d "list dirs and files (detailed)"
   ls -lhF $argv
end

function lt -d "list dirs and files detailed (sort time)"
   ls -lhtF $argv
end

function pls -d "List processes that match a search string"
    set procs (pgrep -f $argv) (echo $status)
    if test $procs[-1] -ne 0
        # procs cmd failed (exit code was non-zero)
        return $procs[-1]
    end
    ps $procs[1..-2]
end

function tarz -d "Archive file(s) into a tar.gz file"
    tar -czf "$argv[1].tar.gz" $argv[1]
end

function taru -d "Extract file(s) from a tar.gz file"
    tar -xf $argv[1]
end

function tmux
   command tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf $argv
   set -g TERM xterm-256color
end

function whichdir -d "Show the directory of an executable in PATH"
   dirname (readlink -f (which $argv))
end

function gvimdiffmax -d "Open maximized gvimdiff bc git difftool w/ gvimdiff
   is an idiot and the LOCAL file (stored in /tmp dir) is deleted, running ls
   revealed only the .LOCAL.swp file still exists"
   gvimdiff -geometry 500x500 $argv
end

# TODO: translate this alias to a function (command substitution in fish works
# differently, I think the $ and " chars are interpretted differently
# alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

