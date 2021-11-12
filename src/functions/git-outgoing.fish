function git-outgoing -d "Show outgoing commits"
   argparse -i 'h/help' 't/to=' -- $argv
   set to_branch "$_flag_to"
   if test "x$to_branch" = "x"
      set to_branch (git_branch_name)
   end
   git fetch --all
   git log "origin/"$to_branch"..HEAD" $argv
end

