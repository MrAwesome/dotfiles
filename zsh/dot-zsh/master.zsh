# From: /mnt/vol/engshare/admin/scripts/master.zshrc
if [[ -z "$ADMIN_SCRIPTS" ]]
then
  export ADMIN_SCRIPTS='/mnt/vol/engshare/admin/scripts'
fi

# things that work in more than just zsh
if [[ "$HOSTNAME" == "devbig577.prn2.facebook.com" ]]
then
    source "$ADMIN_SCRIPTS"/master.shellrc || ( sudo service autofs restart && source "$ADMIN_SCRIPTS"/master.shellrc)
fi

# zsh-specific things below

# load zsh completions
fpath=($fpath "~/.zsh/zsh-completion")

# Load and run completion initialization
autoload -U compinit
compinit -i

# Enable bash completion for select commands
autoload -U bashcompinit
bashcompinit -i
#source "$ADMIN_SCRIPTS/bash-completion/fbmake"
#source "$ADMIN_SCRIPTS/bash-completion/fbconfig"
#source "$ADMIN_SCRIPTS/bash-completion/bistrocli"
#source "$ADMIN_SCRIPTS/bash-completion/aisweeper2"

# Add error code/signal names when a program exits in error (from shellrc)
if test "$ADD_ERRORCODE_TO_PROMPT"; then
   if test "$NO_ERRORCODE_PROMPT" != 1; then
      precmd_functions+=(_errorcode_prompt)
   fi
fi

# Arcanist completions
# source "$ARCANIST_ROOT/resources/shell/bash-completion"

# ig completion
IG_COMPLETE='/mnt/vol/engshare/fbcode/instagram/tools/ig_complete.sh'
if [[ -f "$IG_COMPLETE" ]]; then
    source "$IG_COMPLETE"
fi

# More goodness here..
