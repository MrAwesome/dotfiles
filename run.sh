#!/bin/bash

thisdir="$(dirname "$0")"
cd "$thisdir"

#progs=$(cat active_progs.txt)

# See .gitignore for ignored files
#ignore_regex='(\.vim/|\.zsh/\.zcompdump)'

#which stow >/dev/null || ( echo 'GNU Stow is not installed. Try `sudo pacman -S stow` or `sudo apt install stow`.' && exit 1 )

#for prog in $progs; do
    #echo "Populating dotfiles from '$prog'..."
    #stow -v --dotfiles $prog --ignore="${ignore_regex}"
#done

# Unfortunately, --dotfiles is broken for directories with stow
ln -sf "$(pwd)"/vim/dot-vimrc ~/.vimrc
ln -sf "$(pwd)"/vim/dot-vim ~/.vim
ln -sf "$(pwd)"/zsh/dot-zshrc ~/.zshrc
ln -sf "$(pwd)"/zsh/dot-zsh ~/.zsh
#ln -sf tmux.conf ~/.tmux.conf
ln -sf "$(pwd)"/shell_aliases/dot-glennh_aliases.sh ~/.glennh_aliases.sh
