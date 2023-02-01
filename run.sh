#!/bin/bash

# TODO: find a replacement for stow
# TODO: pull in zsh changes from Dropbox

# set to the absolute location of this script
thisdir="$(cd "$(dirname "$0")" && pwd)"

#progs=$(cat active_progs.txt)

# See .gitignore for ignored files
#ignore_regex='(\.vim/|\.zsh/\.zcompdump)'

#which stow >/dev/null || ( echo 'GNU Stow is not installed. Try `sudo pacman -S stow` or `sudo apt install stow`.' && exit 1 )

#for prog in $progs; do
    #echo "Populating dotfiles from '$prog'..."
    #stow -v --dotfiles $prog --ignore="${ignore_regex}"
#done

# Unfortunately, --dotfiles is broken for directories with stow, so do this by hand until you find a suitable replacement
for dotfiles_filename_local in vim/* \
	zsh/* \
	shell_aliases/*
do
	dotfiles_filename_full="$(pwd)/${dotfiles_filename_local}"

	target_filename=$(echo "$dotfiles_filename_local" | sed -E 's,[^/]+/dot-([^/]+)$,.\1,')
	target_filename_full="${HOME}/${target_filename}"


	if [ -L "$target_filename_full" ] || [ ! -e "$target_filename_full" ]; then
		echo "[INFO] Linking '$target_filename_full' -> '$dotfiles_filename_full'"
		ln -snf "$dotfiles_filename_full" "$target_filename_full"
	else
		echo "[ERROR] '$target_filename_full' exists and is not a symlink, skipping!"
	fi
done

mkdir -p ~/bin

# TODO: log, abstract away
ln -sf "${thisdir}/bin/get_window_paste_xdotool_command.sh" "${HOME}/bin/get_window_paste_xdotool_command.sh"
