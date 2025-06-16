#!/bin/bash

sudo pacman -S git

sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

yay -S --noconfirm --sudoloop openssh xsel 1password firefox nvim

mkdir -p ~/bin/

echo '#!/bin/bash

firefox "$@"' > ~/bin/run-browser.sh

## prime-run here
