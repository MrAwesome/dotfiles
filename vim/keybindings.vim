nmap <Leader>m :make check<CR><CR><CR>
nmap <Leader>M :!reset && cargo test<CR>
nmap <Leader>r :!reset && RUST_BACKTRACE=1 cargo run<CR>
nmap <Leader>c <ESC>:make clippy --all-targets -- -D clippy::pedantic<CR>
nmap <Leader>C <ESC>:!reset && cargo clippy --all-targets -- -D clippy::pedantic<CR>
nmap <Leader>d yiwodbg!(&<ESC>pA);<ESC><CR>

nmap <Space> :Buffers<CR>
nmap <Leader>. <Leader>bej<CR>
nmap <Leader>> <Leader>be
nmap <Leader>t :vert botright term ++cols=40<CR>

" vimgrep on all buffers
nmap <Leader>g :vimgrep // ##ODODODOD
" vimgrep current token on all buffers
nmap <Leader>G yiw/"N:vimgrep /\<"\>/ ##<CR>
nmap  :cn<CR>
nmap  :cp<CR>

"" TODO: make a language-specific and laptop-specific set of files
map <Leader>p oprintln!("{:?}", );<ESC>hi
map <Leader>D O#[derive(Debug)]<ESC>
"
" braces
imap { {<ESC>o}<ESC>kAk<ESC>==$"_xA
imap ( (<ESC>o);<ESC>kAk<ESC>==$"_xA
imap [ [<ESC>o];<ESC>kAk<ESC>==$"_xA

