#!/usr/bin/env fish

function __cat-range
    sed -n $argv[1],$argv[2]"p;"(math $argv[2] + 1)"q" $argv[3]
end

function cat-range -d 'Prints a particular range of lines'
    set parts (string split ':' $argv[1])
    if test (count $parts) = 2
        set last_ln (math $parts[1] + $parts[2])
        __cat-range $parts[1] $last_ln $argv[2]
        return 0
    end
    if test (count $parts) -gt 2
        echo "Invalid argument: "$argv[1]
        return 1
    end
    set parts (string split '-' $argv[1])
    if test (count $parts) = 2
        __cat-range $parts $argv[2]
    end
end

