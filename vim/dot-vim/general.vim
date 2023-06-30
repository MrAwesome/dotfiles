set nocompatible
set hlsearch
set autoindent
set history=1000
set ruler
set showcmd
set encoding=utf-8
set nostartofline

"Enable syntax highlighting
syntax on
filetype on
filetype plugin on
filetype indent on

set laststatus=2
hi StatusLine term=reverse ctermfg=2 ctermbg=white gui=bold,reverse
hi StatusLineNC term=reverse ctermfg=black ctermbg=darkyellow cterm=none
set statusline=%F%m%r%h%w\ %=[C%v,L%l/%L]

" Disable syntax highlighting for lines that are too long (much faster)
set synmaxcol=2048
" Do not redraw when running macros (much faster)
set lazyredraw
" Timeout for macros
set timeoutlen=500

"Fix .sh indentation
augroup sh
    au!
    au FileType sh set nosmartindent autoindent
augroup END

"Fix .sh syntax highlighting
let g:is_posix = 1

"Use four spaces instead of a tab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set shiftround
set nojoinspaces

"Increase number of allowed tabs for multiple file viewing
set tabpagemax=32

" Don't auto-wrap to 80 characters
set tw=0

"Map Y to to yank until EOL, rather than act as yy
map Y y$

"To open files in new tabs instead of buffers in the same tab
" (I do not recommend this - tabs are a crutch.)
"set switchbuf+=usetab,newtab

"Manage multiple buffers better
set hidden

" Some completion servers have issues with backup files
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=1

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" TODO: needed?
" don't give |ins-completion-menu| messages.
"set shortmess+=c

" always show signcolumns
"set signcolumn=yes

"Makes % key more useful
packadd matchit

"Bash-style tab completion, with the ability to tab to complete it

"set wildmenu
"set wildmode=list:longest,full
"set wildmode=list:longest
set wildchar=<Tab> wildmenu wildmode=full
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.o,*.obj,*.bak,*.exe,*~
set wildcharm=<C-Z>

"Case-smart searching
set ignorecase
set smartcase

" Minimal number of lines to scroll when the cursor gets of the screen
set scrolloff=6

"Mouse support
set mouse=a

"Highlight terms incrementally as they're searched
set incsearch

"Makes <CR> unhighlight searches
nnoremap <CR> :nohlsearch<CR>/<BS><CR>

" ` is better than ' so swap them
nnoremap ' `
nnoremap ` '

"Making , the leader key
let mapleader=","

"Can toggle visible tabs and trailing spaces with ,P
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>P :set nolist!<CR>

"Allow backspacing over everything in insert mode
set backspace=indent,eol,start

"Perry's magic line arithmetic - try typing out '9 + 20 * 3' on a line then
"pressing the binding while on that line.
nnoremap \b !!bc<cr>==

" 'Stamp' a word with a replacement word from paste buffer
nnoremap S diw"0P

"Custom keybindings
nmap gr gT
nmap <Leader>, :w
nmap <Leader>< <ESC>:wall<CR>
vmap <Leader>c :s/^/\/\//<CR>
nmap <Leader>k <ESC>:!./%<CR>
nmap <Leader>x :!chmod +x %<CR>l
nmap <Leader>w <C-W><C-W>
nmap <Leader>z :lcl
nmap <Leader>v :tabedit ~/.vim/general.vim<CR>
nmap <Leader>V :source ~/.vimrc<CR>
nmap <Leader>q @w

" TODO: add a function which stores the last-visited tab in a variable, moves
" to that

" Go to last active tab
"
au TabLeave * let g:lasttab = tabpagenr()
"nnoremap <Leader>f :exe "tabn ".g:lasttab<cr>
"vnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
nmap <Leader>1 :tabn 1<CR>
nmap <Leader>2 :tabn 2<CR>
nmap <Leader>3 :tabn 3<CR>
nmap <Leader>4 :tabn 4<CR>
nmap <Leader>5 :tabn 5<CR>
nmap <Leader>6 :tabn 6<CR>
nmap <Leader>7 :tabn 7<CR>
nmap <Leader>8 :tabn 8<CR>
nmap <Leader>9 :tabn 9<CR>
nmap <Leader>0 :tabn 10<CR>

" (other bindings in plugins.vim)

"nmap <Leader>l :autocmd FileType python match OverLength /\%81v.*/:set filetype=python<CR>

nmap gw <C-W><C-W>

nmap <F7> :set invspell<ESC>
nmap <F8> 1z=

set pastetoggle=<F10>

nmap <up> gk
nmap <down> gj

inoremap <Nul> <C-x><C-o>

" Create Blank Newlines and stay in Normal mode
nmap <silent> zj mzo<ESC>cc<ESC>'z
nmap <silent> zk mzO<ESC>cc<ESC>'z

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Make tabs show up red
syn match tab display "\t"
hi link tab Error

"sacrilege?
" nnoremap : ;
nnoremap <C-;> ;
noremap ; :

" Replace word with paste buffer
nnoremap S diw"0P

" Command line bindings
cmap  <Home>
cmap  <End>

" Enable mouse and fix paste in alacritty
if $TERM == 'alacritty'
  set ttymouse=sgr
  set t_BE=
endif
