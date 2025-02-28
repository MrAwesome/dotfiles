#!/usr/bin/env bash

# TODO: find a replacement for stow
# TODO: pull in zsh changes from Dropbox

set -euo pipefail

# set to the absolute location of this script
thisdir="$(cd "$(dirname "$0")" && pwd)"
cd "$thisdir"

#progs=$(cat active_progs.txt)

# See .gitignore for ignored files
#ignore_regex='(\.vim/|\.zsh/\.zcompdump)'

#which stow >/dev/null || ( echo 'GNU Stow is not installed. Try `sudo pacman -S stow` or `sudo apt install stow`.' && exit 1 )

#for prog in $progs; do
#echo "Populating dotfiles from '$prog'..."
#stow -v --dotfiles $prog --ignore="${ignore_regex}"
#done

# TODO: abstract away
mkdir -p "${HOME}/.config/tmux"
ln -snf "${thisdir}/config/tmux/tmux.conf" "${HOME}/.config/tmux/tmux.conf"
echo "[config/tmux/tmux.conf]"
echo "${HOME}/.config/tmux/tmux.conf ->
    ${thisdir}/config/tmux/tmux.conf"
echo

mkdir -p "${HOME}/.config/nvim"
ln -snf "${thisdir}/config/nvim/init.vim" "${HOME}/.config/nvim/init.vim"
echo "[config/nvim/init.vim]"
echo "${HOME}/.config/nvim/init.vim ->
    ${thisdir}/config/nvim/init.vim"
echo


# Unfortunately, --dotfiles is broken for directories with stow, so do this by hand until you find a suitable replacement
for filename_local in vim/* \
    xinitrc/* \
    Xdefaults/* \
    zsh/* \
    shell_aliases/* \
    wezterm/*
do
    echo "[$filename_local]"

    final_linkname_no_dot=$(echo "$filename_local" | sed -E 's,[^/]+/dot-([^/]+)$,\1,')
    # if the filename ends in -hostname:<hostname>, then only link it if the hostname matches
    has_hostname=$(echo "$filename_local" | rg '/dot-[^/]*?-hostname:[^/]+$' || true)
    if [[ "$has_hostname" != "" ]]; then
        desired_hostname=$(echo "$filename_local" | sed -E 's,[^/]+/dot-[^/]+-hostname:([^/]+)$,\1,')
        current_hostname=$([ -f /etc/hostname ] && cat /etc/hostname || hostname -s)
        if [[ "$desired_hostname" != "$current_hostname" ]]; then
            echo "(SKIP: hostname mismatch)"
            echo
            #echo "[INFO] Skipping '$target_filename_full' because hostname '$hostname' does not match '${hostname}'"
            continue
        else
            final_linkname_no_dot=$(echo "$filename_local" | sed -E 's,[^/]+/dot-([^/]+)(-hostname:[^/]+)$,\1,')
        fi

    fi

    target_filename_full="${thisdir}/${filename_local}"

    linkname_full="${HOME}/.${final_linkname_no_dot}"

    if [ -L "$linkname_full" ] || [ ! -e "$linkname_full" ]; then
        echo "$linkname_full ->"
        echo "   $target_filename_full"
        ln -snf "$target_filename_full" "$linkname_full"
        echo
    else
        echo "[ERROR] '$linkname_full' exists and is not a symlink, skipping!"
        echo
    fi
done

mkdir -p ~/bin

echo "[bin/]"
# TODO: log, abstract away
for file in bin/*; do
    linkname_full="${HOME}/${file}"
    target_filename_full="${thisdir}/${file}"
    echo "  $linkname_full ->"
    echo "     $target_filename_full"

    ln -sf "$target_filename_full" "$linkname_full"
done
#ln -sf "${thisdir}/bin/get_window_paste_xdotool_command.sh" "${HOME}/bin/get_window_paste_xdotool_command.sh"
#ln -sf "${thisdir}/bin/weechat_tmux.sh" "${HOME}/bin/weechat_tmux.sh"
#ln -sf "${thisdir}/bin/pro_controller.sh" "${HOME}/bin/pro_controller.sh"
#ln -sf "${thisdir}/bin/startnv" "${HOME}/bin/startnv"
#ln -sf "${thisdir}/bin/startamd" "${HOME}/bin/startamd"
