#!/usr/bin/env bash

REM_HOST="gleesus.net"

# If running over ssh, connect to the remote tmux session
if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
    tmux attach-session -t weechat || tmux new-session -s weechat
else
    ssh "$REM_HOST" "./bin/weechat_tmux.sh"
fi
