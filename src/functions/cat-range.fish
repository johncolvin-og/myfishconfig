#!/usr/bin/env fish

function cat-range
    function impl
        sed -n $argv[1],$argv[2]"p;"(math $argv[2] + 1)"q" $argv[3]
    end
    set parts (string split ':' $argv[1])
    if test (count $parts) = 2
        set last_ln (math $parts[1] + $parts[2] - 1)
        impl $parts[1] $last_ln $argv[2]
        return 0
    end
    if test (count $parts) -gt 2
        echo "Invalid argument: "$argv[1]
        return 1
    end
    set parts (string split '-' $argv[1])
    if test (count $parts) = 2
        impl $parts $argv[2]
    end
end

