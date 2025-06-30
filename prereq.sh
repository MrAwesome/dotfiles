#!/bin/bash

sudo pacman -S --needed git

command -v yay || ( sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si )

yay -S --needed --noconfirm --sudoloop \
    1password \
    7zip \
    firefox \
    fzf \
    nvim \
    openssh \
    rsync \
    signal-desktop \
    vesktop \
    unzip \
    xlockmore \
    xsel \
    wireguard-tools

mkdir -p ~/bin/

echo '#!/bin/bash

firefox "$@"' > ~/bin/run-browser.sh
chmod +x ~/bin/run-browser.sh

## prime-run here

echo '#!/bin/bash

"$@"' > ~/bin/prime-run
chmod +x ~/bin/prime-run
