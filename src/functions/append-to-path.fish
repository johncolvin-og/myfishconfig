function append-to-path -d "Appends a path to the PATH variable if it exists"
   if test -e $argv[1]
      set PATH $PATH $argv[1]
   end
end
