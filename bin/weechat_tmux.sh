#!/usr/bin/env bash

REM_HOST="gleesus.net"

# TODO: check for .weechat_master instead, and set that from ansible
if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
    tmux attach-session -t weechat || \
        # start and attach to weechat session:
        (tmux new-session -s weechat -d weechat && \
            tmux attach-session -t weechat)
else
    ssh -t "$REM_HOST" "./bin/weechat_tmux.sh"
fi
