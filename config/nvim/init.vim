set notermguicolors
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
lua require('my_async')
source ~/.vimrc
