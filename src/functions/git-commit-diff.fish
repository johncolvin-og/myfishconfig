function git-commit-diff
    argparse -i 'h/help' 'f/file=' 'from-head=' 'from=' 'to-tip' 'l/length=' 'slice=' 'q/quiet' -- $argv

    function print_help
        echo "\
Usage: git-commit-diff [OPTIONS]

Options:
  -f,--file          The file to diff
  --slice            Specifies the commit slice (in the pythonic sense) to diff
  -q,--quiet         Don't print the commits that are being compared (just the diff)
"
    end

    if test (set -q _flag_file; echo $status) != 0
        echo 'No file specified' 1>&2
        print_help
        return 1
    end

    set file $_flag_file
    set all_commits (git rev-list HEAD -- $file)

    if test (set -q _flag_slice; echo $status) = 0
        set slice (string split ':' $_flag_slice)
        if test (count $slice) = 1
            set commits $all_commits[$slice[1]]
        else if test (count $slice) = 2
            set commits $all_commits[$slice[1]..$slice[2]]
        else
            echo 'Invalid slice specified'
            print_help
            return 1
        end
    else
        echo 'No slice specified'
        print_help
        return 1
    end

    if test (set -q _flag_quiet; echo $status) != 0
        # Example that uses custom formatting to display commits
        # echo 'Showing diff from '(git show --format '%H%n%an <%ae>%n%cd%n%n%s' -s $commits[-1])

        echo -e 'Showing diff for '(count $commits)' commits\n'
        echo '****END******'
        git show --pretty -s $commits[1]
        echo -ne '\n...\n'
        git show --pretty -s $commits[-1]
        echo -e '****BEGIN****\n'
    end

    if test (count $commits) = 1
        git diff $commits[1]~..$commits[1] -- **$file
    else
        git diff $commits[-1]..$commits[1] -- **$file
    end
end

