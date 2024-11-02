#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#

export EDITOR="vim"

export ADMIN_SCRIPTS=/mnt/vol/engshare/admin/scripts
[ -f "${ADMIN_SCRIPTS}/scm-prompt" ] && source "${ADMIN_SCRIPTS}/scm-prompt"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
HISTORY_IGNORE="(ls|cd|pwd|exit|cd|k|j)"
SAVEHIST=10000
setopt appendhistory
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
#setopt SHARE_HISTORY

#export CDPATH=~

## never ever beep ever
setopt NO_BEEP
unsetopt beep

# vim mode
bindkey -v
export KEYTIMEOUT=1

# Load and run completion initialization
fpath+=($HOME/.zsh/completion)

autoload -Uz compinit
compinit
#
# Enable bash completion for select commands
autoload -U bashcompinit
bashcompinit -i


#allow tab completion in the middle of a word
#setopt COMPLETE_IN_WORD

## keep background processes at full speed
setopt NOBGNICE

## automatically decide when to page a list of completions
LISTMAX=0

## disable mail checking
#MAILCHECK=0

autoload -U colors
colors

setopt PROMPT_SUBST
#export PROMPT='%F{yellow}[%F{cyan}%D{%a %y/%m/%d %R %Z}%F{yellow}]%F{yellow}[%F{green}%l%F{yellow}]$([[ `_dotfiles_scm_info` == "" ]] || echo "%F{yellow}[%F{cyan}$(_dotfiles_scm_info | sed "s/^ //g" | tr -d "()")%F{yellow}]")%(?..[%F{red}%?%1v%F{yellow}] )
#%F{yellow}<%F{green}%n@%m%F{white}:%F{yellow}%~%F{yellow}>
#%f%B$%b '

if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
    export hostname_color="%F{magenta}"
else
    export hostname_color="%F{green}"
fi

export PROMPT='%F{yellow}[%F{cyan}%D{%a %y/%m/%d %R %Z}%F{yellow}]%F{yellow}[%F{green}%l%F{yellow}]%(?..[%F{red}%?%1v%F{yellow}] )
%F{yellow}<%F{green}%n@'"${hostname_color}"'%m%F{white}:%F{yellow}%~%F{yellow}>
%f%B$%b '

#export PROMPT='%F{yellow}[%F{cyan}%D{%a %y/%m/%d %R %Z}%F{yellow}]%F{yellow}[%F{green}%l%F{yellow}]%F{yellow}])%(?..[%F{red}%?%1v%F{yellow}] )
#%F{yellow}<%F{green}%n@%m%F{white}:%F{yellow}%~%F{yellow}>
#%f%B$%b '

# Real comments
setopt interactivecomments
