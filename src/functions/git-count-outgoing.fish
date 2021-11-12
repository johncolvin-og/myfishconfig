function git-count-outgoing -d "Count outgoing commits"
   argparse -i 'h/help' 't/to=' -- $argv
   set to_branch "$_flag_to"
   if test "x$to_branch" = "x"
      set to_branch (git_branch_name)
   end
   git fetch --all
   git rev-list "origin/"$to_branch"..HEAD" --count $argv
end
