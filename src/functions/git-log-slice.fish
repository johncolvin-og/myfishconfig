function git-log-slice -d 'Show for log a slice of commits'
    set commits (git-commit-slice $argv)
    if test (count $commits) -eq 0
        echo 'Commit slice empty'
        return 1
    end
    git show -s $commits
end

