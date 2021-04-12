#!/usr/bin/env fish

function print_help_and_exit
  echo "\
Usage: git-clone [OPTIONS] source-path dest-prefix

Positionals:
  source-name         The repository's name within the domain
  dest-prefix         The destination prefix path on this machine

Options:
  --dest-name         The name of the repo on this machine
  --source-prefix     The domain the repo is in (defaults to git@github.com:)
  -h,--help           Print this help message and exit

"
    return $argv
end

function git-clone -d "Clone a git repository"
    set source_prefix "git@github.com:"
    set source_name ""
    set dest_prefix ""
    set dest_name ""
    set i 1
    set positionals
    while test $i -le (count $argv)
        switch $argv[$i]
            case '--source-prefix'
                set i (math $i + 1)
                set source_prefix $argv[$1]
            case '--source-name'
                set i (math $i + 1)
                set source_name $argv[$1]
            case '--dest-prefix'
                set i (math $i + 1)
                set dest_prefix $argv[$1]
            case '--dest-name'
                set i (math $i + 1)
                set dest_name $argv[$1]
            case '-s'
                set simulate 1
            case '--simulate'
                set simulate 1
            case '-h'
                print_help_and_exit 0
                return 0
            case '--help'
                print_help_and_exit 0
                return 0
            case '-v'
                set verbose 1
            case '--verbose'
                set verbose 1
            case '*'
                # Treat unmatched args as positionals
                set -a positionals $argv[$i]
        end
        set i (math $i + 1)
    end

    # Assign positionals that weren't explicit options
    set pos 1

    # 1) source_name
    if test "$source_name" = ""
        set source_name $positionals[$pos]
        set pos (math $pos + 1)
    end

    # 2) dest_prefix
    if test "$dest_prefix" = ""
        if test $pos -le (count $positionals)
            set dest_prefix $positionals[$pos]
            set pos (math $pos + 1)
        else
            set dest_prefix "public"
        end
    end

    # 3) dest_name
    if test "$dest_name" = ""
        set src "$source_prefix/$source_name"
        set repo_path (string split / $src)
        set dest_name "$repo_path[-1]"
    end

    set dest_path $REPOS_HOME/$dest_prefix/$dest_name

    if test "x$verbose" != "x"
        echo "source prefix "$source_prefix
        echo "source name "$source_name
        echo "dest prefix "$dest_prefix
        echo "dest name "$dest_name
        echo "dest path "$dest_path
    end

    if test "x$simulate" != "x"
        echo "git clone "$source_prefix/$source_name "$dest_path"
    else
        eval "git clone "$source_prefix/$source_name "$dest_path"
    end
end

