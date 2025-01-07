#!/usr/bin/env zsh
print -Pn "\e]0;NEEDS_ATTENTION\a" 
sleep .1
win_id=$(xdotool search --name NEEDS_ATTENTION)
wmctrl -b add,demands_attention -ir "$win_id"
print -Pn "\e]0;zsh\a" 
