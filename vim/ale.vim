let g:ale_hack_hack_executable = 'hh'
" let g:ale_linters = { 'hack': ['hack', 'aurora'], 'rust': ['cargo'] }
let g:ale_linters = { 'hack': ['hack', 'aurora'], 'python': ['pyre'], 'rust': ['rls'] }
let g:ale_echo_msg_format = '[%linter%]% [code]% %s'

let g:ale_fix_on_save = 1
let g:ale_fixers = { 
  \ 'rust': ['rustfmt'], 
  \ 'javascript': ['eslint', 'prettier'], 
  \ 'python': ['black', 'isort'], 
  \ 'yaml': ['remove_trailing_lines', 'trim_whitespace']
  \ }

let g:ale_rust_rls_toolchain = 'stable'
let g:ale_rust_rls_executable = '/usr/bin/rls'

let g:ale_completion_enabled = 0
if v:version >= 800
  "let g:ale_completion_enabled = 1
  nnoremap <silent> K :ALEHover<CR>
  "nnoremap <silent> gd :ALEGoToDefinition<CR>
  "nnoremap <silent> gb :ALEGoToDefinitionInTab<CR>
  "nnoremap <M-LeftMouse> <LeftMouse>:ALEGoToDefinition<CR>

  "" show type on hover
  "if v:version >= 801
  "set balloonevalterm
  "let g:ale_set_balloons = 1
  "endif
endif

