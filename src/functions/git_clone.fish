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

function git_clone -d "Clone a git repository"
    argparse 'h/help' 'source_prefix' 'source_name' 'dest_prefix' 'dest_name' -- $argv

    set -q _flag_help
    if test $status = 0
        print_help_and_exit 0
        return 0
    end

    set pos 1
    if test "x$_flag_source_name" = "x"
        if test (count $argv) -ge $pos
            set _flag_source_name $argv[$pos]
            set pos (math $pos + 1)
        else
            print_help_and_exit 1
            return 1
        end
    end

    if test "x$_flag_source_prefix" = "x"
        set _flag_source_prefix "git@github.com:"
    end

    if test "x$_flag_dest_prefix" = "x"
        set _flag_dest_prefix "public"
    end
    
    if test "x$_flag_dest_name" = "x"
        if test (count $argv) -ge $pos
            set _flag_dest_name "/"$argv[$pos]
            set pos (math $pos + 1)
        else
            set _flag_dest_name "/"
        end
    end

    set dest_path $REPOS_HOME/$_flag_dest_prefix$_flag_dest_name

    echo "git clone "$_flag_source_prefix/$_flag_source_name
    echo "into "$dest_path
    eval "git clone "$_flag_source_prefix/$_flag_source_name
    return 0
end
