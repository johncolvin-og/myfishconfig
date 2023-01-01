#!/usr/bin/env fish

function grepi -d "grep w/ common flags"
    grep -rnHIi $argv
end

function grepic -d "grep w/ common flags and colored output"
    grep -rnHIi --color=always $argv
end

function lessq -d "less pager fit to screen"
   less --quit-if-one-screen $argv
end

function l -d "list dirs then files"
   ls --group-directories-first -CF $argv
end

function ll -d "list dirs and files (detailed)"
   ls -lhF $argv
end

function la "list dirs and files w/ hidden (detailed)"
   ls -Ah $argv
end

function lt "list dirs and files detailed (sort time)"
   ls -lhtF $argv
end

function ldf "list dirs then files (sort name, detailed)"
   ls --group-directories-first -lhsF $argv
end

function ldfa -d "list dirs then files w/ hidden (sort name, detailed)"
   ls --group-directories-first -lhsAF $argv
end

function pls -d "List processes that match a search string"
    set procs (pgrep -f $argv) (echo $status)
    if test $procs[-1] -ne 0
        # procs cmd failed (exit code was non-zero)
        return $procs[-1]
    end
    ps $procs[1..-2]
end

function tarz "Archive file(s) into a tar.gz file"
    tar -czf "$argv[1].tar.gz" $argv[1]
end

function taru "Extract file(s) from a tar.gz file"
    tar -xf $argv[1]
end

function tmux
   command tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf $argv
   set -g TERM xterm-256color
end

function whichdir -d "Show the directory of an executable in PATH"
   dirname (readlink -f (which $argv))
end

# TODO: translate this alias to a function (command substitution in fish works
# differently, I think the $ and " chars are interpretted differently
# alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

