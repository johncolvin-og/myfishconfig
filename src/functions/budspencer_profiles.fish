#!/usr/bin/env fish

function set_prompt_bg
   set -U my_prompt_user_bg $argv[1]
   set -U my_prompt_at_bg $argv[1]
   set -U my_prompt_host_bg $argv[1]
   set -U my_prompt_grad1_bg $argv[1] $argv[1] $argv[1] $argv[1]
   set -U my_prompt_wd_bg $argv[1]
   set -U my_prompt_symbols_bg $argv[1]
end

function set_profile_pastel_titan
   set -U my_prompt_user_fg $my_gray
   set -U my_prompt_at_fg $my_hotdog_mustard_yellow
   set -U my_prompt_host_fg $my_pastel_purple
   set -U my_prompt_grad1_fg $my_semi_dark_gray $my_gray $my_semi_light_gray
   set -U my_prompt_wd_fg $my_pastel_blue
   set -U my_prompt_symbols_fg $my_pastel_blue
   set -U my_prompt_grad1_symbol '' '' ''
   set_prompt_bg $my_dark_gray
   # set -U my_prompt_grad1_bg[1] $my_dark_gray2
   # set -U my_prompt_grad1_bg[2] $my_semi_dark_gray
   # set -U my_prompt_grad1_bg[3] $my_semi_dark_gray2
   set -U my_prompt_wd_bg $my_dark_gray2
end

function set_profile_pee_and_poop
   set -U my_prompt_user_fg $budspencer_colors[6]
   set -U my_prompt_at_fg $my_hotdog_mustard_yellow
   set -U my_prompt_host_fg $my_hotdog_mustard_yellow
   set -U my_prompt_grad1_fg $my_dark_gray $my_gray
   set -U my_prompt_grad1_symbol ''
   set -U my_prompt_wd_fg $my_gray
   set_prompt_bg $budspencer_colors[2]
end
