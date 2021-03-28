###############################################################################
#
# Prompt theme name:
#   budspencer
#
# Description:
#   a sophisticated airline/powerline theme
#
# Original Author:
#   Joseph Tannhuber <sepp.tannhuber@yahoo.de>
#
# Additional edits and bug fixes:
#   Clayton Auld <clayauld@gmail.com>
#
# Sections:
#   -> TTY Detection
#   -> Functions
#     -> Toggle functions
#     -> Command duration segment
#     -> Git segment
#     -> PWD segment
#   -> Prompt
#
###############################################################################

###############################################################################
# => TTY Detection
###############################################################################

# Automatically disables right prompt when in a tty
# Except in Darwin due to OS X terminals identifying themselves as a tty
# Bug fix for WSL terminals as these, too, identify themselves as a tty
if not test (uname) = Darwin
  if not test (uname -r | /bin/grep microsoft)
    if tty | /bin/grep tty >/dev/null
      exit
    end
  end
end

source (realpath (dirname (status -f)))"/agnoster_fish_right_prompt.fish"
source (realpath (dirname (status -f)))"/batman_fish_right_prompt.fish"
source (realpath (dirname (status -f)))"/functions/__budspencer_prompt_git_branch_right.fish"
source (realpath (dirname (status -f)))"/functions/__budspencer_is_git_ahead_or_behind.fish"
source (realpath (dirname (status -f)))"/functions/__budspencer_is_git_stashed.fish"
source (realpath (dirname (status -f)))"/functions/__budspencer_git_status.fish"

source (realpath (dirname (status -f)))"/functions/__batman_color_dim.fish"
source (realpath (dirname (status -f)))"/functions/__batman_color_fst.fish"
source (realpath (dirname (status -f)))"/functions/__batman_color_off.fish"
source (realpath (dirname (status -f)))"/functions/__batman_color_snd.fish"
source (realpath (dirname (status -f)))"/functions/__batman_color_trd.fish"
###############################################################################
# => Functions
###############################################################################

#####################
# => Toggle functions
#####################
function __budspencer_toggle_symbols -d 'Toggles style of symbols, press # in NORMAL or VISUAL mode'
  if [ $symbols_style = 'symbols' ]
    set symbols_style 'numbers'
  else
    set symbols_style 'symbols'
  end
  set pwd_hist_lock true
  commandline -f repaint
end

function __budspencer_toggle_pwd -d 'Toggles style of pwd segment, press space bar in NORMAL or VISUAL mode'
  for i in (seq (count $budspencer_pwdstyle))
    if [ $budspencer_pwdstyle[$i] = $pwd_style ]
      set pwd_style $budspencer_pwdstyle[(expr $i \% (count $budspencer_pwdstyle) + 1)]
      set pwd_hist_lock true
      commandline -f repaint
      break
      end
  end
end

#############################
# => Command duration segment
#############################

function __budspencer_cmd_duration -d 'Displays the elapsed time of last command'
  set -l seconds ''
  set -l minutes ''
  set -l hours ''
  set -l days ''

  set -l cmd_duration (math -s0 $CMD_DURATION / 1000)
  if [ $cmd_duration -gt 0 ]
    set seconds (math -s0 $cmd_duration % 60)'s'
    if [ $cmd_duration -ge 60 ]
      set minutes (math -s0 $cmd_duration % 3600 / 60)'m'
      if [ $cmd_duration -ge 3600 ]
        set hours (math -s0 $cmd_duration % 86400 / 3600)'h'
        if [ $cmd_duration -ge 86400 ]
          set days (math -s0 $cmd_duration / 86400)'d'
        end
      end
    end
    set_color $budspencer_colors[2]
      echo -n ''
      switch $pwd_style
        case short long
          if [ $last_status -ne 0 ]
            echo -n (set_color -b $budspencer_colors[2] $budspencer_colors[7])' '$days$hours$minutes$seconds' '
          else
            echo -n (set_color -b $budspencer_colors[2] $budspencer_colors[12])' '$days$hours$minutes$seconds' '
          end
      end
    set_color -b $budspencer_colors[2]
  end
end

function __budspencer_prompt_git_symbols -d 'Displays the git symbols'
  set -l is_repo (command git rev-parse --is-inside-work-tree 2> /dev/null)
  if [ -z $is_repo ]
    return
  end

  set -l git_ahead_behind (__budspencer_is_git_ahead_or_behind)
  set -l git_status (__budspencer_git_status)
  set -l git_stashed (__budspencer_is_git_stashed)

  if [ (expr $git_ahead_behind[1] + $git_ahead_behind[2] + $git_status[1] + $git_status[2] + $git_status[3] + $git_status[4] + $git_status[5] + $git_status[6] + $git_stashed) -ne 0 ]
    set_color $budspencer_colors[3]
    # set_color $my_prompt_symbols_fg
    echo -n ''
    set_color -b $budspencer_colors[3]
    switch $pwd_style
      case long short git
        if [ $symbols_style = 'symbols' ]
          if [ $git_ahead_behind[1] -gt 0 ]
            set_color -o $budspencer_colors[5]
            echo -n ' ↑'
          end
          if [ $git_ahead_behind[2] -gt 0 ]
            set_color -o $budspencer_colors[5]
            echo -n ' ↓'
          end
          if [ $git_status[1] -gt 0 ]
            set_color -o $budspencer_colors[12]
            echo -n ' +'
          end
          if [ $git_status[2] -gt 0 ]
            set_color -o $budspencer_colors[7]
            echo -n ' –'
          end
          if [ $git_status[3] -gt 0 ]
            set_color -o $budspencer_colors[10]
            echo -n ' ✱'
          end
          if [ $git_status[4] -gt 0 ]
            set_color -o $budspencer_colors[8]
            echo -n ' →'
          end
          if [ $git_status[5] -gt 0 ]
            set_color -o $budspencer_colors[9]
            echo -n ' ═'
          end
          if [ $git_status[6] -gt 0 ]
            set_color -o $budspencer_colors[4]
            echo -n ' ●'
          end
          if [ $git_stashed -gt 0 ]
            set_color -o $budspencer_colors[11]
            echo -n ' ✭'
          end
        else
          if [ $git_ahead_behind[1] -gt 0 ]
            set_color $budspencer_colors[5]
            echo -n ' '$git_ahead_behind[1]
          end
          if [ $git_ahead_behind[2] -gt 0 ]
            set_color $budspencer_colors[5]
            echo -n ' '$git_ahead_behind[2]
          end
          if [ $git_status[1] -gt 0 ]
            set_color $budspencer_colors[12]
            echo -n ' '$git_status[1]
          end
          if [ $git_status[2] -gt 0 ]
            set_color $budspencer_colors[7]
            echo -n ' '$git_status[2]
          end
          if [ $git_status[3] -gt 0 ]
            set_color $budspencer_colors[10]
            echo -n ' '$git_status[3]
          end
          if [ $git_status[4] -gt 0 ]
            set_color $budspencer_colors[8]
            echo -n ' '$git_status[4]
          end
          if [ $git_status[5] -gt 0 ]
            set_color $budspencer_colors[9]
            echo -n ' '$git_status[5]
          end
          if [ $git_status[6] -gt 0 ]
            set_color $budspencer_colors[4]
            echo -n ' '$git_status[6]
          end
          if [ $git_stashed -gt 0 ]
            set_color $budspencer_colors[11]
            echo -n ' '$git_stashed
          end
        end
        set_color -b $budspencer_colors[3] normal
        echo -n ' '
    end
  end
end

###############################################################################
# => Prompt
###############################################################################

function fish_right_prompt -d 'Write out the right prompt of the budspencer theme'
   echo -n -s (__budspencer_cmd_duration) (__budspencer_prompt_git_symbols)
   prompt_vi_mode
   # batman_fish_right_prompt
   __budspencer_prompt_git_branch_right
   set my_prompt_clock_fg $my_light_gray
   set my_prompt_clock_bg $my_dark_gray
   set_color -o $my_prompt_clock_fg
   set_color -b $my_prompt_clock_bg
   # echo -n " "(date +%H:%M:%S)

  # set_color -o $my_prompt_grad1_fg[1]
  # set_color -b $my_prompt_grad1_bg[1]
  echo -n ' '
  set i 1
  # set my_prompt_right_grad1_fg $my_prompt_grad1_fg
  # set my_prompt_right_grad1_bg $my_prompt_grad1_bg
  # set my_prompt_right_grad1_symbol $my_prompt_grad1_symbol
  for grad_fg in $my_prompt_right_grad1_fg
    set_color -b $my_prompt_right_grad1_bg[$i]
    set_color -o $grad_fg
    echo -n $my_prompt_right_grad1_symbol[$i]
    set i (math $i + 1)
  end
  echo -n ' '
   printf (__batman_color_dim)(date +%H(__batman_color_fst):(__batman_color_dim)%M(__batman_color_fst):(__batman_color_dim)%S)(__batman_color_off)
   set_color normal
end
