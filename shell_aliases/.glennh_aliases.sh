export PATH="$PATH:$HOME/.cargo/bin"

export CONSOLE_BROWSER=elinks

# Convenience functions for editing configs quickly
alias vimvim='vim ~/.vim/plugins.vim ~/.vimrc ~/.vim/*.vim'
alias val="vim ~/.glennh_aliases.sh && source ~/.glennh_aliases.sh"

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
    git diff-tree --no-commit-id --name-only -r HEAD | awk '{ print "'"$PREFIX"'" $1 }'
    git status -u -s | sed "s/^...//"
    for f in $*; do
        echo "$f"
    done
}

vac () {
    vim $(gac $* | shuf)
}

hgrep () { rg $* $HISTFILE }

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

gcommit () { git add -A && git commit -m "$1" }
gpush () { git add -A && git commit -m "$1" && git push }

cdrust () { cd ~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/ }
cdrustcargo () { echo 'USING 1ecc RUST CHECKOUT'; cd ~/.cargo/registry/src/github.com-1ecc6299db9ec823/ }

rustcargosearch () { cdrustcargo && find . | rg '\.rs$' | xargs rg $* }
rustsearch () { cdrust && find . | rg '\.rs$' | xargs rg $* }
alias rcs='rustcargosearch '
alias rs='rustsearch '

vimruwi () { cd ~/ruwi && vim $(find src/ tests/ | rg '\.rs$' | shuf) Cargo.toml }
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

vimchataigi () {
    setopt nullglob
    cd ~/ChhaTaigi/ &&
    vim src/{ChhaTaigi.tsx,{{,*/}*.css,*.js,*.ts,*.tsx}} \
    public/{index.html,manifest.json} \
    {tsconfig.json,tsconfig.server.json,package.json,webpack.server.js} \
    $*
}
alias vt=vimchataigi

alias rc='sudo loadkeys <<< "keycode 58 = Escape"'
alias tm='tmux attach || tmux'

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


source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
