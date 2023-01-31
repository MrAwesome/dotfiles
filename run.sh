#!/bin/bash -x

progs=$(cat active_progs.txt)

which stow >/dev/null || ( echo 'GNU Stow is not installed. Try `sudo pacman -S stow` or `sudo apt install stow`.' && exit 1 )

for prog in $progs; do
    echo "Populating dotfiles from '$prog'..."
    stow --dotfiles $prog
done
