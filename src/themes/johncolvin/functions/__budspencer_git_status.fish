function __budspencer_git_status -d 'Check git status'
  set -l git_status (command git status --porcelain 2> /dev/null | cut -c 1-2)
  set -l added (echo -sn $git_status\n | egrep -c "[ACDMT][ MT]|[ACMT]D")
  set -l deleted (echo -sn $git_status\n | egrep -c "[ ACMRT]D")
  set -l modified (echo -sn $git_status\n | egrep -c ".[MT]")
  set -l renamed (echo -sn $git_status\n | egrep -c "R.")
  set -l unmerged (echo -sn $git_status\n | egrep -c "AA|DD|U.|.U")
  set -l untracked (echo -sn $git_status\n | egrep -c "\?\?")
  echo -n $added\n$deleted\n$modified\n$renamed\n$unmerged\n$untracked
end
