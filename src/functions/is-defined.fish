function is-defined
    argparse 'q/quiet' -- $argv
    if set -q _flag_quiet; and test $status = 0
        set -q argv[1]
        # echo $status
        return $status
    end
    set -q argv[1]
    echo $status
end

