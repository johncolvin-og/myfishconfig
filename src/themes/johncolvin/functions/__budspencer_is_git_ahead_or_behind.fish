function __budspencer_is_git_ahead_or_behind -d 'Check if there are unpulled or unpushed commits'
  if set -l ahead_or_behind (command git rev-list --count --left-right 'HEAD...@{upstream}' 2> /dev/null)
    echo $ahead_or_behind | sed 's|\s\+|\n|g'
  else
    echo 0\n0
  end
end
