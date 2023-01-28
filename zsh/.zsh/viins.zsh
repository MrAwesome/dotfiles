bindkey -M viins "\e." insert-last-word
bindkey -M viins "^?" backward-delete-char
bindkey -M viins "^[[A" history-beginning-search-backward
bindkey -M viins "^[[B" history-beginning-search-forward
bindkey -M viins "^L" clear-screen
bindkey -M viins "^A" beginning-of-line
bindkey -M viins "^E" end-of-line
bindkey -M viins "^W" backward-kill-word
bindkey -M viins "^U" backward-kill-line
bindkey -M viins "^K" vi-kill-eol
bindkey -M viins "^R" history-incremental-search-backward

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey "^[m" copy-earlier-word

real-paste() {
    zle vi-put-before
}
zle -N real-paste
bindkey -M viins "^Y" real-paste
