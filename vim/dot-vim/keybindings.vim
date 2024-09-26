" nmap <Leader>m :make check --all-targets<CR><CR><CR>

"nmap <Leader>M :!reset && cargo test<CR>
nmap <Leader>r :!reset && RUST_BACKTRACE=1 cargo run<CR>
nmap <Leader>R :!reset && RUST_BACKTRACE=1 cargo run --release<CR>
nmap <Leader>c <ESC>:make clippy --all-targets -- -D clippy::pedantic<CR>
nmap <Leader>C <ESC>:!reset && cargo clippy --all-targets -- -D clippy::pedantic<CR>
nmap <Leader>d yiwodbg!(&<ESC>pA);<ESC><CR>

" JS/TS function bind
" nmap ,B yiw?constructor(^Mf{%Othis.<ESC>pa = this.<ESC>pa.bind(this);<ESC>^M
" nmap ,b diwathis.<ESC>pa = this.<ESC>pa.bind(this);<ESC>^M

nmap <Space> :Buffers<CR>
nmap <Leader>. <Leader>bej<CR>
nmap <Leader>> <Leader>be
nmap <Leader>T :vert botright term ++cols=40<CR>

" vimgrep on all buffers
nmap <Leader>g :vimgrep /\C/ ##ODODODOD
nmap [1;2S :vimgrep /\C/ ##ODODODOD
" vimgrep current token on all buffers
nmap <Leader>G yiw/"N:vimgrep /\<"\>\C/ ##<CR>

" Jump between quickfix items with Control-N/P
nnoremap <C-n> <Cmd>NextOrJumpToTop<CR>
nnoremap <C-p> <Cmd>BetterCMove prev<CR>

au BufNewFile,BufRead *.rs map <Leader>p oprintln!("{:?}", );<ESC>hi
"" TODO: make a language-specific and laptop-specific set of files
au BufNewFile,BufRead *.rs map <Leader>D O#[derive(Debug)]<ESC>

" braces
imap { {<ESC>o}<ESC>kAk<ESC>==$"_xA
imap ( (<ESC>o);<ESC>kAk<ESC>==$"_xA
imap [ [<ESC>o];<ESC>kAk<ESC>==$"_xA


let g:firstrun = 0

func! JumpFixedDispatch(t)
    let g:firstrun = 1

    if a:t == 'make'
        Make
    elseif a:t == 'dispatch'
        Dispatch
    endif
endfunc
command -nargs=1 JumpFixedDispatch call JumpFixedDispatch(<f-args>)

func! NextOrJumpToTop()
    let x = 0
    let msg = ''
    " if s:firstrun is 1, echo lol
    try
        if g:firstrun == 1
            cfirst
        else
            BetterCMove next
        endif
    catch
        let msg = v:errmsg
    endtry

    if msg != ''
        echohl ErrorMsg
        echo msg
        echohl None
    endif

    let g:firstrun = 0
endfunc
command NextOrJumpToTop call NextOrJumpToTop()

func! BetterCMove(t)
    let msg = ''
    try 
        if a:t == 'prev'
            cprev
        else
            cnext
        endif
        echon ''
    catch /^Vim\%((\a\+)\)\=:E553/
        let msg = 'E553: No more items'

        if a:t == 'prev'
            silent! clast
        else
            silent! cfirst
        endif
    catch /^Vim\%((\a\+)\)\=:E42/
        let msg = 'E42: No Errors'
    endtry

    if msg != ''
        echohl ErrorMsg
        echo msg
        echohl None
    endif
endfunc
command -nargs=1 BetterCMove call BetterCMove(<f-args>)


"func! MyFilt(cmd)
"    let parts = split(a:cmd, '|')
"    let vimcmd = trim(parts[0])
"    let shcmd = trim(parts[1])
"    echom trim(system(shcmd, execute(vimcmd)))
"endfunc
":command -nargs=1 MyFilt call MyFilt(<f-args>)

" Highlight characters over 280 in a line.
function! Highlight280()
    syntax match OverLength /\%>280v./
    hi OverLength ctermbg=red ctermfg=white guibg=red guifg=white
endfunction

" Create a keybinding to call Highlight280 function.
nnoremap <leader>h :call Highlight280()<CR>

function! AIFilterFunction(prefix)
    let filetext = join(getline(1,'$'), "\n")
    let aiinput = "Perform the following actions WITHOUT any explanations. Return only code, and do NOT include triple backticks at the beginning and end." . a:prefix . "\n\n" . filetext
    let aioutput = system("ai", aiinput)
    echo aioutput
endfunction

"command! -range=% AIFilter <line1>,<line2> call AIFilterFunction(<f-args>)
