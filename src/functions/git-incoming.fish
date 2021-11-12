function git-incoming -d "Show incoming commits" 
   argparse -i 'h/help' 'f/from=' -- $argv
   set from_branch "$_flag_from"
   if test "x$from_branch" = "x"
      set from_branch (git_branch_name)
   end
   git fetch --all
   git log HEAD.."origin/"$from_branch
end

