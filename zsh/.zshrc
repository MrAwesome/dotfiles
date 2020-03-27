HOMEDIR="/home/$USER"
ZDOTDIR="${HOMEDIR}/.zsh"
PATH="${PATH}:${HOMEDIR}/.local/bin"

# FB master.zshrc
source "${HOMEDIR}/.zsh/master.zsh"

# General settings for Glenn
source "${HOMEDIR}/.zsh/general.zsh"

# Custom vim keybindings to get the good stuff back from emacs mode
source "${HOMEDIR}/.zsh/viins.zsh"

# Fuzzyfinder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Glenny's custom aliases
[ -f "${HOMEDIR}/.glennh_aliases.sh" ] && source "${HOMEDIR}/.glennh_aliases.sh"

# # glennh's custom sush defines
[ -f "${HOMEDIR}/.sushrc" ] && source "${HOMEDIR}/.sushrc"

alias daytime=$'printf \'\033]10;black\007\'; printf \'\033]11;white\007\''
alias nighttime=$'printf \'\033]10;white\007\'; printf \'\033]11;black\007\''

alias bounce_interface='sudo ifconfig wlp3s0 down; sudo ifconfig wlp3s0 up'


alias fb='fbterm -s 18 --font-names="Source Code Variable"'
alias fbt='fbterm -s 18 --font-names="xos4 Terminus"'

