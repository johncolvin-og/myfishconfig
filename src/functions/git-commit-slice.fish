function git-commit-slice -d 'Get hash codes for a slice of commits'
    argparse -i 'h/help' 'f/file=' 'slice=' -- $argv
    if test (is-defined $_flag_file) != 0
        echo 'No file specified'
        return 1
    end

    set file $_flag_file
    set all_commits (git rev-list HEAD -- $file)
    if test (is-defined $_flag_slice) = 0
        set slice_str $_flag_slice
    else if test (is-defined $argv[1]) = 0
        set slice_str $argv[1]
    else
        echo 'No slice specified'
        return 1
    end

    set slice (string split ':' $slice_str)
    if test (count $slice) = 1
        set commits $all_commits[$slice[1]]
    else if test (count $slice) = 2
        set commits $all_commits[$slice[1]..$slice[2]]
    else
        echo 'Invalid slice specified'
        return 1
    end
    echo $commits
end

