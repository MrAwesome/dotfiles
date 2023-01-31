export PATH="$PATH:$HOME/.cargo/bin"

export CONSOLE_BROWSER=elinks

# Convenience functions for editing configs quickly
alias vimvim='vim ~/.vim/plugins.vim ~/.vimrc ~/.vim/*.vim'
alias val="vim ~/.glennh_aliases.sh && source ~/.glennh_aliases.sh"
alias vimawesome="cd ~/.config/awesome/gimpy/ && vim *.lua"


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

gac () {
    gac_inner $* | sort | uniq
}

gac_inner () {
    PREFIX="$(git rev-parse --show-toplevel)/"
    git status -u --porcelain=v1 | sed 's/^...//' | awk '{ print "'"$PREFIX"'" $1 }'
    #git diff-tree --no-commit-id --name-only -r HEAD | awk '{ print "'"$PREFIX"'" $1 }'
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

booknew() {
    cd ~/Dropbox/rust/rust_book_work
    cargnew $*
}

cracknew() {
    cd ~/Dropbox/rust/cracking_in_rust
    cargnew $*
}

cargnew() {
    if [ ! -d "$_" ]; then
        cargo new --lib $*
    fi
    cd $_
    vim -O src/main.rs src/lib.rs
}

alias brite='sudo brightness_ronnie.sh'
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
    cd ~/ruwi && vim $(find src/ tests/ | rg '\.rs$' | shuf) Cargo.toml
}
installruwi () {
    sudo -v &&
    cd ~/ruwi &&
    cargo test --release &&
    cargo build --release &&
    sudo cp ./target/release/ruwi /usr/local/bin  &&
    echo '[DONE] Installed ruwi!'
}

alias vr=vimruwi
alias cdr='cd ~/ruwi'

alias ct='cd ~/Liburry'
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

alias rc='sudo loadkeys <<< "keycode 58 = Escape"'
alias tm='tmux attach || tmux'

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
        du -sh * | rg '^[0-9\.]+G'
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
    cd ~/openai-cli
    ts-node src/index.ts $*
    cd - > /dev/null
}
