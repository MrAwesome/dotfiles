" Remove trailing whitespace on save
autocmd BufWritePre *.tw,*.rb,*.cconf,*.cinc,*.cpp,*.php,*.py :%s/\s\+$//e

au BufNewFile,BufRead *.tw,*.py,*.cconf,*.mconf,*.cinc setlocal ft=python sw=4 ts=4 sts=4 et

au BufNewFile,BufRead *.rb setlocal ft=ruby syntax=ruby expandtab shiftwidth=2 softtabstop=2 tabstop=2

au BufNewFile,BufRead *.php setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
au BufNewFile,BufRead *.js setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
au BufNewFile,BufRead *.c setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
au BufNewFile,BufRead *.yml setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2

"autocmd FileType php setlocal iskeyword+=:,-

" If we're in a typescript project, use tsc errorformat
if filereadable('tsconfig.json')
    "au VimEnter * set errorformat=%f(%l\\,%c):%m
    "au VimEnter * set errorformat=%E%f\ %#(%l\\,%c):\ error\ %m,%E%f %#(%l\\,%c)\: %m,%Eerror\ %m,%C%\\s%\+%m
    "let &errorformat = '%E%f %#(%l\,%c): error %m,%E%f %#(%l\,%c): %m,%Eerror %m,%C%\s%\+%m'
    compiler tsc
endif
