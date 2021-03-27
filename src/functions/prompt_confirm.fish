function prompt_confirm
   if test (count $argv) = 0 -o "$argv" = ""
      set msg "Please confirm"
   else
      set msg $argv
   end
   function __print_prompt_msg
      set_color yellow
      echo -n $argv" "
      set_color normal
      echo -n "["
      set_color green
      echo -n "Yes"
      set_color normal
      echo -n "/"
      set_color red
      echo -n "n"
      set_color normal
      echo -n "]:"
   end
   read -p '__print_prompt_msg $msg' -l reply
   if test $reply = 'Yes'
      return 0
   end
   return 1
end

