#!/bin/bash

w=$(xdotool getactivewindow)

# get the window id of the active window
window=$(xprop -id "$w")

# get the pid of the active window
pid=$(echo "$window" | grep -oP 'PID\(\w+\) = \K\d+')

# get the memory map of the active window
maps=$(pmap "$pid")

# check if the window is gtk or qt
is_gtk=$(echo "$maps" | grep -oP 'libgtk')
is_qt=$(echo "$maps" | grep -oP 'libQt')

#echo "is gtk: $is_gtk"
#echo "is qt: $is_qt"

# get the clipboard command

if echo "$window" | grep -q wezterm; then
    #setxkbmap
    #xdotool getwindowfocus key --window %1 keyup shift
    #setxkbmap
    #glxgears
    #xdotool getwindowfocus key --window %1 ctrl+shift+v
    #sleep .1
    #xdotool getwindowfocus windowactivate --window %1 --sync
    #xdotool getwindowfocus windowfocus --window %1 --sync
    #xdotool getwindowfocus key --window %1 ctrl+F9
    #WINDOW_ID=$(xdotool getactivewindow)
    #xdotool keyup --clearmodifiers super
    #xdotool windowminimize --sync "$WINDOW_ID"
    #sleep .1
    #xdotool windowactivate --sync "$WINDOW_ID"
    sleep .4
    xdotool getwindowfocus key --window "$WINDOW_ID" ctrl+F9
elif [ -n "$is_gtk" ] || [ -n "$is_qt" ]; then
    #xsel -b -o
    xdotool getwindowfocus key --window %1 ctrl+shift+v
else
    #xclip -o

    # store the current mouse position
    xdotool getmouselocation --shell > /tmp/mouse_location

    # move mouse to active window
    xdotool getwindowfocus mousemove --window %1 5 5
    xdotool key --clearmodifiers shift click 2

    # move mouse back to original position
    source /tmp/mouse_location
    xdotool mousemove $X $Y

    # activate the original active window
    xdotool windowactivate "$w"
fi
