" nmap <Leader>m :make check --all-targets<CR><CR><CR>
nmap <Leader>m :AsyncMake<CR>
nmap <Leader>M :!reset && cargo test<CR>
nmap <Leader>r :!reset && RUST_BACKTRACE=1 cargo run<CR>
nmap <Leader>R :!reset && RUST_BACKTRACE=1 cargo run --release<CR>
nmap <Leader>c <ESC>:make clippy --all-targets -- -D clippy::pedantic<CR>
nmap <Leader>C <ESC>:!reset && cargo clippy --all-targets -- -D clippy::pedantic<CR>
nmap <Leader>d yiwodbg!(&<ESC>pA);<ESC><CR>

nmap <Space> :Buffers<CR>
nmap <Leader>. <Leader>bej<CR>
nmap <Leader>> <Leader>be
nmap <Leader>t :vert botright term ++cols=40<CR>

" vimgrep on all buffers
nmap <Leader>g :vimgrep /\C/ ##ODODODOD
nmap [1;2S :vimgrep /\C/ ##ODODODOD
" vimgrep current token on all buffers
nmap <Leader>G yiw/"N:vimgrep /\<"\>\C/ ##<CR>

" Jump between quickfix items with Control-N/P
nnoremap  <Cmd>NextOrJumpToTop<CR>
nnoremap  <Cmd>cprev<CR>

au BufNewFile,BufRead *.rs map <Leader>p oprintln!("{:?}", );<ESC>hi
"" TODO: make a language-specific and laptop-specific set of files
au BufNewFile,BufRead *.rs map <Leader>D O#[derive(Debug)]<ESC>

" braces
imap { {<ESC>o}<ESC>kAk<ESC>==$"_xA
imap ( (<ESC>o);<ESC>kAk<ESC>==$"_xA
imap [ [<ESC>o];<ESC>kAk<ESC>==$"_xA


let s:firstrun = 0

func! AsyncMake()
    let s:firstrun = 1
    Make
endfunc
command AsyncMake call AsyncMake()

func! NextOrJumpToTop()
    let x = 0
    let msg = ''
    " if s:firstrun is 1, echo lol
    try
        if s:firstrun == 1
            cfirst
        else
            cnext
        endif
    catch
        let msg = v:errmsg
    endtry

    echohl ErrorMsg
    echo msg
    echohl None

    let s:firstrun = 0
endfunc
command NextOrJumpToTop call NextOrJumpToTop()


"func! MyFilt(cmd)
"    let parts = split(a:cmd, '|')
"    let vimcmd = trim(parts[0])
"    let shcmd = trim(parts[1])
"    echom trim(system(shcmd, execute(vimcmd)))
"endfunc
":command -nargs=1 MyFilt call MyFilt(<f-args>)
