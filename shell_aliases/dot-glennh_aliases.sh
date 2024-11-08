export ANDROID_SDK_ROOT="/home/glenn/Android/Sdk"
export ANDROID_HOME="/home/glenn/Android/Sdk"
#export ANDROID_HOME="/opt/android-sdk"
export PATH="$PATH:$HOME/.cargo/bin:$HOME/bin"

export CONSOLE_BROWSER=elinks

# Convenience functions for editing configs quickly
alias vimvim='vim ~/.vim/plugins.vim ~/.vimrc ~/.vim/*.vim'
alias val="vim ~/.glennh_aliases.sh && source ~/.glennh_aliases.sh"
alias cdawesome="cd ~/.config/awesome/gimpy/"
alias vimawesome="cd ~/.config/awesome/gimpy/ && vim *.lua"


alias webshare="ip addr show | rg inet.192; php -S 0.0.0.0:6969"
alias moonshine="cd ~/code/moonshine && cargo run --release -- config.toml"

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
    git add -A && git commit -m "$1"
}
gpush () {
    git add -A && git commit -m "$1" && git push
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
    cdrustcargo && find . | rg '\.rs$' | xargs rg $*
}
rustsearch () {
    cdrust && find . | rg '\.rs$' | xargs rg $*
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
alias cdr='cd ~/code/ruwi'

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

alias cdd='cd ~/code/decktricks'
alias cddd='cd ~/code/decktricks/gui/godot'
vimdeck() {
    cdd
    vim TODO src/*.rs src/*/*.rs tests/*/*.{rs,json} config.json Cargo.toml
}
alias vd='vimdeck'
decktricks() {
    (cdd && cargo run --quiet -- $*)
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
        du -sh * | rg '^[0-9\.]+G'

        if [ -n "$ZSH_VERSION" ]; then
            du -sh .* | rg '^[0-9\.]+G'
        fi
    else
        du -sh $* | rg '^[0-9\.]+G'
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
    SCRIPT_DIR="${HOME}/code/openai-cli"
    yarn \
        --cwd="${SCRIPT_DIR}" \
        run -s ts-node \
        "${SCRIPT_DIR}/src/index.ts" openai-completion $*
}

code() {
    ai -M 4096 "The following instructions are from a command-line program on Arch Linux. The user wants only code results. Do *not* wrap code in triple backticks. Do *not* give any explanations at all. Just code. Instructions start now:

$*"
}

gen_unit_tests() {
    filename="$1"
    test_filename="${filename%.*}.test.ts"

    file_contents=""
    if [[ -f "${test_filename}" ]]; then
        file_contents=$(cat "${test_filename}")
    fi

    #-m 'code-davinci-002' \
    ai -M 1500 \
        -m 'text-davinci-003' \
        -f "${filename}" \
        --prompt-prefix "// Path: ${filename}" \
        --prompt-suffix "// Path: ${test_filename}
// Generate a typescript test file with unit tests for ${filename}, using the 'jest' library.
// Generate at least 20 test cases.
// Use the 'test.each' function to generate test cases (the 'data provider' pattern).
// Be thorough. Test all the edge cases you can think of. Do not generate any other files, just this test file.

${file_contents}" \
        >> "${test_filename}"
}

bp() {(
    cd ~/code/bp-monitor || exit
    ts-node src/index.ts $*
)}

yarninit() {
    mkdir -p src/
    yarn add ts-node typescript $*
    yarn add --dev @types/node
    #yarn add -D @types/node eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin prettier eslint-config-prettier eslint-plugin-prettier
    touch src/index.ts
}

gpt4() {
    SCRIPT_DIR="${HOME}/code/openai-cli"
    yarn \
        --cwd="${SCRIPT_DIR}" \
        run -s ts-node \
        ${SCRIPT_DIR}/misc/testGPT4.ts $*
}

ca() {
    cd ~/code/openai-cli
}

va() {
    ca
    vim \
        src/index.ts \
        $(find src | rg '\.ts$')
}

ntfs_rsync() {
    rsync --progress -P -rDvz $*
}

mw() {
    ~/syncthing/morrowind/run.sh
}
