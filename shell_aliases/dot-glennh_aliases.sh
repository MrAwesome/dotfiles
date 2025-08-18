export ANDROID_SDK_ROOT="/home/glenn/Android/Sdk"
export ANDROID_HOME="/home/glenn/Android/Sdk"
#export ANDROID_HOME="/opt/android-sdk"
export PATH="$PATH:$HOME/.cargo/bin:$HOME/bin"

export CONSOLE_BROWSER=elinks

alias moutn=mount # lmao

# Convenience functions for editing configs quickly
alias vim=nvim
alias oldvim=/usr/bin/vim
alias vimvim='vim ~/.vim/plugins.vim ~/.vimrc ~/.vim/*.vim'
alias val="vim ~/.glennh_aliases.sh && source ~/.glennh_aliases.sh"
alias cdawesome="cd ~/.config/awesome/gimpy/"
alias vimawesome="cd ~/.config/awesome/gimpy/ && vim *.lua"

alias kf="killall firefox"

alias webshare="ip addr show | rg inet.192; php -S 0.0.0.0:6969"
alias moonshine="cd ~/code/moonshine && while :; do git pull; cargo run --release -- config.toml; sleep 10; done"

if command -v yarnpkg &>/dev/null; then
    alias yarn=yarnpkg
fi

alias ls='ls --color=auto'
alias rc='sudo loadkeys <<< "keycode 58 = Escape"'
alias tm='tmux attach || tmux'
alias py='python3'

# "vim all changed"
#alias vac=$'vim $(git diff-tree --no-commit-id --name-only -r HEAD && git status -s | awk \'{print $2}\')'

#repocommand () {
#    if git rev-parse --is-inside-work-tree 1>/dev/null; then
#        cmd=$1
#        pushd $(git rev-parse --show-toplevel) &>/dev/null
#        shift 1
#        $cmd $*
#        popd &>/dev/null
#    fi
#}

deps () {
    pacman -Qi $* | grep -e Depends -e Optional
}

gac () {
    gac_inner $* | sort | uniq
}

gac_inner () {
    PREFIX="$(git rev-parse --show-toplevel)/"
    git status -u --porcelain=v1 | sed 's/^...//' | awk '{ print "'"$PREFIX"'" $1 }'
    git diff-tree --no-commit-id --name-only -r HEAD | awk '{ print "'"$PREFIX"'" $1 }'
    #all=$(echo "$current" "$older" | sort | uniq)
    #git status -u -s | sed "s/^...//"
    for f in $*; do
        echo "$f"
    done
}

vac () {
    vim $(gac $* | shuf)
}

hgrep () {
    rg $* $HISTFILE
}

hcat () {
    cat $HISTFILE
}

cargnew() {
    if [ ! -d "$_" ]; then
        cargo new --lib $*
    fi
    cd $_
    vim -O src/main.rs src/lib.rs
}

alias brite='sudo brightness.sh'
alias j='source ~/Dropbox/journal/aliases.sh; j'

ddg() {
  PREFIX='https://duckduckgo.com/lite/?q='
  SEARCH_STRING=$(echo "$*" | sed 's/ /+/g')
  $CONSOLE_BROWSER "${PREFIX}${SEARCH_STRING}"
}

gcommit () {
    git add -A && git commit -m "$*"
}
gpush () {
    git add -A && git commit -m "$*" && git push
}
alias gds='git diff --staged'

cdrust () {
    cd ~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/
}
cdrustcargo () {
    echo 'USING 1ecc RUST CHECKOUT'
    cd ~/.cargo/registry/src/github.com-1ecc6299db9ec823/
}

rustcargosearch () {
    cdrustcargo && find . | rg '\.rs$' | xargs rg "$@"
}
rustsearch () {
    cdrust && find . | rg '\.rs$' | xargs rg "$@"
}
alias rcs='rustcargosearch '
alias rs='rustsearch '

vimruwi () {
    cd ~/code/ruwi && vim $(find src/ tests/ | rg '\.rs$' | shuf) Cargo.toml
}
installruwi () {
    sudo -v &&
    cd ~/code/ruwi &&
    cargo test --release &&
    cargo build --release &&
    sudo cp ./target/release/ruwi /usr/local/bin  &&
    echo '[DONE] Installed ruwi!'
}

alias vr=vimruwi

alias ct='cd ~/code/Liburry'
lintaigi() {
    setopt nullglob
    ct &&
    yarn run eslint $(find src/ | rg '\.(tsx|ts|js|cjs|mjs)$')
}

vimchhataigi() {
    setopt nullglob
    ct &&
    vim src/client/ChhaTaigi.tsx \
    $(find src/ | rg -v 'src/generated' | rg '\.(tsx|ts|js|cjs|mjs|css|yml)$') \
    public/{index.html,site.webmanifest} \
    {tsconfig.json,tsconfig.scripts.json,package.json,*.js} \
    README.md \
    $*
}
alias vt=vimchhataigi
alias st='ct; BROWSER=none HTTPS=true yarn start'
alias tt='ct; CI=true yarn test --color --no-watch'
alias ttt='ct; yarn test --color'

alias deploytaigi='tt && (ct; export REACT_APP_LIBURRY_BUILD="chhataigi"; yarn build) && echo y | gcloud app deploy --project chhataigi'

alias cdp='cd ~/code/playground'
alias vp='cdp && vim src/main.rs'

alias cdd='cd ~/code/decktricks'
alias cddg='cd ~/code/decktricks/gui/godot'
alias cddr='cd ~/code/decktricks/gui/rust'
alias cddw='cd ~/code/decktricks-website'
vimdeck() {
    cdd
    vim TODO src/*.rs src/*/*.rs build_assets/bin/* ci_scripts/*.sh scripts/*.sh .github/workflows/* tests/*/*.{rs,json} config.json Cargo.toml README.md CONTRIBUTING.md
}
vimdeckplus() {
    cddr
    vim src/dispatcher.rs src/*.rs tests/*.rs ../../TODO ../../src/*.rs ../../src/*/*.rs ../../tests/*/*.{rs,json} ../../config.json ../../Cargo.toml Cargo.toml
}
alias vd='vimdeck'
alias vdg='cddg; vim scripts/Main.gd scripts/*.gd scenes/*.tscn'
alias vdr='vimdeckplus'
decktricks() {
    (cdd && cargo run --quiet -- "$@")
}

alias wgup="sudo wg-quick up wg0"
alias wgdown="sudo wg-quick down wg0"
alias wged="wgdown; sudo vim /etc/wireguard/wg0.conf; wgup"

jcat() {
    cat "$1" | jq
}

jless() {
    jcat "$1" | less
}

cjcat() {
    csvtojson "$1" | jq
}

cjless() {
    cjcat "$1" | less
}

if [ -n "$ZSH_VERSION" ]; then
    [ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
    [ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
fi

jsontocsv() {
    #                                                    vvv !!! hack !!! vvvvvvvvvvvvvvvvvvvvvv  
    jq -r '(map(keys) | add | unique) as $cols | map(. | select(.optionDeliverablesList == null) as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv' "$1"
}

filesize() {
    if [[ "$*" == "" ]]; then
        # will only work in zsh
        du -sh ./* 2> /dev/null | rg '^[0-9\.]+G'

        if [ -n "$ZSH_VERSION" ]; then
            du -sh .* 2> /dev/null | rg '^[0-9\.]+G'
        fi
    else
        du -sh "$@" 2> /dev/null | rg '^[0-9\.]+G'
    fi
}
alias fs=filesize

# remove any newlines at the end of a file
trimnewline() {
    perl -i -0pe 's/\n\Z//' "$1"
}

latlong() {
    #urlencode the args
    arg=$(echo "$*" | jq -s -R -r @uri)
    resp=$(curl -s "https://geocode.search.hereapi.com/v1/geocode?q=${arg}&limit=1&apiKey=$(cat ~/.hereapi)")


    gotres=$(echo "$resp" | jq -r '.items[0]')

    if [[ "$gotres" == "" || "$gotres" == "null" ]]; then
        echo "Failed to find a result."
        return
    fi

    # if access is available, use access, otherwise use position
    echo "$resp" | jq -r '.items[0] | (.access[0] // .position) | [.lat, .lng] | @csv'
}

ai() {
    # Stealing -p for prefix since it's easier to type
    if [[ "$1" == "-p" ]]; then
        prompt_override="$2"
        shift; shift

        if [[ "$1" == "" ]]; then
            prompt_prefix="$*"
        else
            prompt_prefix="$prompt_override"
        fi
    else
        prompt_prefix="The following prompt input is from a user who values clarity and brevity. You can give full answers, but don't pontificate. User input starts below the following three dash marks:
---
"
    fi

    SCRIPT_DIR="${HOME}/code/openai-cli"
    yarn \
        --cwd="${SCRIPT_DIR}" \
        run -s ts-node \
        "${SCRIPT_DIR}/src/index.ts" \
        openai-completion \
        --prompt-prefix "$prompt_prefix" \
        "$@"

    [[ -t 1 ]] && sleep .1
    [[ -t 1 ]] && ~/bin/win_grab_attention.zsh
}

code() {
    SCRIPT_DIR="${HOME}/code/openai-cli"
    yarn \
        --cwd="${SCRIPT_DIR}" \
        run -s ts-node \
        "${SCRIPT_DIR}/src/index.ts" \
        openai-completion \
        -M 8192 \
        --prompt-prefix "The following instructions are from a command-line program on Arch Linux. The user wants only code results. Do *not* wrap code in triple backticks. Do *not* give any explanations at all. Just code. Only return code. Take your time to reason and write high-quality code. The user values brevity, but only when it does not come at the expense of correctness. So be brief, but above all be correct. 

Instructions start below the 3 dash marks on the following line:
---
" \
    "$@" | sed '1{/^```/d};$ {/^```/d}'


}

bp() {(
    cd ~/code/bp-monitor || exit
    ts-node src/index.ts "$@"
)}

yarninit() {
    mkdir -p src/
    yarn add ts-node typescript "$@"
    yarn add --dev @types/node
    #yarn add -D @types/node eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin prettier eslint-config-prettier eslint-plugin-prettier
    touch src/index.ts
}

cai() {
    cd ~/code/openai-cli
}

vai() {
    ca
    vim \
        src/index.ts \
        $(find src | rg '\.ts$')
}

ntfs_rsync() {
    rsync --progress -P -rDvz "$@"
}

get_porkflaps() {
    if timeout 1 getent hosts porkflaps 1>&2; then
        echo -n "porkflaps"
    else
        # TODO: match on /etc/localtime to pick a vpn
        echo -n "10.8.0.8"
    fi
}

sp() {
    ssh "$(get_porkflaps)" "$@"
}

spcp() {
    scp "$(get_porkflaps)":"$1" "$2"
}

dtlocal() {
    sp -t 'zsh -ic "source ~/.glennh_aliases.sh && cddg && ./dev_build.sh"' &&
    ntfs_rsync "$(get_porkflaps)":'code/decktricks/gui/godot/build/' ~/code/builds/decktricks/ &&
    ~/code/builds/decktricks/decktricks-gui
}

getsteamdeck() {
    if timeout 1 getent hosts steamdeck 1>&2; then
        echo -n "steamdeck"
    else
        # TODO: match on /etc/localtime to pick a vpn
        echo -n "10.8.0.64"
    fi
}

sshdeck() {
    ssh deck@"$(getsteamdeck)" "$@"
}

rtmfix() {
    prefix="$(cat .rtm_shared_secret)"

    cleaned="$(echo -n "$1" | sed 's/api_sig=\w*//')"
    suffix="$(echo -n "$1" | sed 's/^https.*?//' | tr -d '&=')"

    api_sig=$(echo -n "${prefix}${suffix}" | md5sum | awk '{ print $1; }')

    echo "${cleaned}&api_sig=${api_sig}"
}
