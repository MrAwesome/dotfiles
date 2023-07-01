#!/usr/bin/env bash

REM_HOST="gleesus.net"

# TODO: if weechat master, start weechat service in tmux instead of waiting for connect to start it?
# TODO: check for .weechat_master instead, and set that from ansible
if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
    tmux new-session -A -s weechat weechat
else
    ssh -t "$REM_HOST" "./bin/weechat_tmux.sh"
fi
