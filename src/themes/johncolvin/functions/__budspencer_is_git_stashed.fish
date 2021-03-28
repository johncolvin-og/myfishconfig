function __budspencer_is_git_stashed -d 'Check if there are stashed commits'
  command git log --format="%gd" -g $argv 'refs/stash' -- 2> /dev/null | wc -l | tr -d '[:space:]'
end
