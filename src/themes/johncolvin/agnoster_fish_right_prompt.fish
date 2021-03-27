# right prompt for agnoster theme
# shows vim mode status

# ===========================
# Color setting

# You can set these variables in config.fish like:
# set -g color_dir_bg red
# If not set, default color from agnoster will be used.
# ===========================
set -q color_vi_mode_indicator; or set color_vi_mode_indicator black
set -q color_vi_mode_normal; or set color_vi_mode_normal green
set -q color_vi_mode_insert; or set color_vi_mode_insert blue 
set -q color_vi_mode_visual; or set color_vi_mode_visual red

# ===========================
# Cursor setting

# You can set these variables in config.fish like:
# set -g cursor_vi_mode_insert bar_blinking
# ===========================
set -q cursor_vi_mode_normal; or set cursor_vi_mode_normal box_steady
set -q cursor_vi_mode_insert; or set cursor_vi_mode_insert bar_steady
set -q cursor_vi_mode_visual; or set cursor_vi_mode_visual box_steady


function fish_cursor_name_to_code -a cursor_name -d "Translate cursor name to a cursor code"
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

function prompt_vi_mode -d 'vi mode status indicator'
  set -l right_segment_separator \uE0B2
  switch $fish_bind_mode
      case default
        set -l mode (fish_cursor_name_to_code $cursor_vi_mode_normal)
        echo -e "\e[\x3$mode q"
        set_color $color_vi_mode_normal
      case insert
        set -l mode (fish_cursor_name_to_code $cursor_vi_mode_insert)
        echo -e "\e[\x3$mode q"
        set_color $color_vi_mode_insert
      case visual
        set -l mode (fish_cursor_name_to_code $cursor_vi_mode_visual)
        echo -e "\e[\x3$mode q"
        set_color $color_vi_mode_visual
    end
end

source (realpath (dirname (status -f)))"/functions/__batman_color_dim.fish"
source (realpath (dirname (status -f)))"/functions/__batman_color_fst.fish"
source (realpath (dirname (status -f)))"/functions/__batman_color_off.fish"
source (realpath (dirname (status -f)))"/functions/__batman_color_snd.fish"
source (realpath (dirname (status -f)))"/functions/__batman_color_trd.fish"

function git::is_stashed
  command git rev-parse --verify --quiet refs/stash >/dev/null
end

function git::get_ahead_count
  echo (command git log 2> /dev/null | grep '^commit' | wc -l | tr -d " ")
end

function git::branch_name
  command git symbolic-ref --short HEAD
end

function git::is_touched
  test -n (echo (command git status --porcelain))
end

function batman_fish_right_prompt
  set -l code $status
  test $code -ne 0; and echo (__batman_color_dim)"("(__batman_color_trd)"$code"(__batman_color_dim)") "(__batman_color_off)

  if test -n "$SSH_CONNECTION"
     printf (__batman_color_trd)":"(__batman_color_dim)"$HOSTNAME "(__batman_color_off)
   end

  if git rev-parse 2> /dev/null
    git::is_stashed; and echo (__batman_color_trd)"^"(__batman_color_off)
    printf (__batman_color_snd)"("(begin
      if git::is_touched
        echo (__batman_color_trd)"*"(__batman_color_off)
      else
        echo ""
      end
    end)(__batman_color_fst)(git::branch_name)(__batman_color_snd)(begin
      set -l count (git::get_ahead_count)
        if test $count -eq 0
          echo ""
        else
          echo (__batman_color_trd)"+"(__batman_color_fst)$count
        end
    end)(__batman_color_snd)") "(__batman_color_off)
  end
  printf (__batman_color_dim)(date +%H(__batman_color_fst):(__batman_color_dim)%M(__batman_color_fst):(__batman_color_dim)%S)(__batman_color_off)" "
end

function agnoster_fish_right_prompt -d 'Prints right prompt'
  if test "$fish_key_bindings" = "fish_vi_key_bindings"
    prompt_vi_mode
    set_color normal
  end
end
