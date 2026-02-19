if has("nvim")
    colorscheme nightfox
    highlight Operator    gui=bold
    highlight Statement   gui=bold
    highlight Conditional gui=bold
    highlight Comment     gui=italic
    highlight Function    gui=italic
    highlight Keyword     gui=bold
    highlight Identifier  gui=NONE
    highlight String      gui=italic
    highlight Constant    gui=bold
    highlight PreProc     gui=bold
    highlight Type        gui=italic
    highlight Special     gui=NONE
    highlight Underlined  gui=underline
    highlight Todo        gui=bold,italic
    highlight Error       gui=reverse
else
    colorscheme default
    highlight Operator     cterm=bold
    highlight Statement    cterm=bold
    highlight Conditional  cterm=bold
    highlight Comment      cterm=italic
    highlight Function     cterm=italic
    highlight Keyword      cterm=bold
    highlight Identifier   cterm=NONE
    highlight String       cterm=italic
    highlight Constant     cterm=bold
    highlight PreProc      cterm=bold
    highlight Type         cterm=italic
    highlight Special      cterm=NONE
    highlight Underlined   cterm=underline
    highlight Todo         cterm=bold,italic
    highlight Error        cterm=reverse
endif

