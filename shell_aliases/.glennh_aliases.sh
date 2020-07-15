export PATH="$PATH:$HOME/.cargo/bin"

export CONSOLE_BROWSER=elinks 

# Convenience functions for editing configs quickly
alias vimvim='vim ~/.vim/plugins.vim ~/.vimrc ~/.vim/*.vim'
alias val="vim ~/.glennh_aliases.sh && source ~/.glennh_aliases.sh"

# "vim all changed"
#alias vac=$'vim $(git diff-tree --no-commit-id --name-only -r HEAD && git status -s | awk \'{print $2}\')'
alias vac='git status 1>/dev/null && vim $(git status -u -s | sed "s/^...//")'

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

cdrust () { cd ~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src }
cdrustcargo () { cd ~/.cargo/registry/src/github.com-*/ }

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
alias rc='sudo loadkeys <<< "keycode 58 = Escape"'
alias rw='sudo ruwi -s fzf'
alias tm='tmux attach || tmux'

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
