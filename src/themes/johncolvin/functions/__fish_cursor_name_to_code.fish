function __fish_cursor_name_to_code -a cursor_name -d "Translate cursor name to a cursor code"
  # these values taken from
  # https://github.com/gnachman/iTerm2/blob/master/sources/VT100Terminal.m#L1646
  # Beginning with the statement "case VT100CSI_DECSCUSR:"
  if [ $cursor_name = "box_blinking" ]
    echo 1
  else if [ $cursor_name = "box_steady" ]
    echo 2
  else if [ $cursor_name = "underline_blinking" ]
    echo 3
  else if [ $cursor_name = "underline_steady" ]
    echo 4
  else if [ $cursor_name = "bar_blinking" ]
    echo 5
  else if [ $cursor_name = "bar_steady" ]
    echo 6
  else
    echo 2
  end
end
