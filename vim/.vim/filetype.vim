" Remove trailing whitespace on save
autocmd BufWritePre *.tw,*.rb,*.cconf,*.cinc,*.cpp,*.php,*.py :%s/\s\+$//e

au BufNewFile,BufRead *.tw,*.py,*.cconf,*.mconf,*.cinc setlocal ft=python sw=4 ts=4 sts=4 et

au BufNewFile,BufRead *.rb setlocal ft=ruby syntax=ruby expandtab shiftwidth=2 softtabstop=2 tabstop=2

au BufNewFile,BufRead *.php setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
au BufNewFile,BufRead *.js setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
au BufNewFile,BufRead *.c setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
au BufNewFile,BufRead *.yml setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2

"autocmd FileType php setlocal iskeyword+=:,-
