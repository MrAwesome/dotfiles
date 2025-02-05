if has("nvim")
    colorscheme nightfox
    highlight Comment    gui=italic
    highlight Function   gui=bold,italic
    highlight Keyword    gui=bold
    highlight Identifier gui=NONE
    highlight String     gui=italic
    highlight Constant   gui=bold
    highlight Statement  gui=NONE
    highlight PreProc    gui=bold
    highlight Type       gui=italic
    highlight Special    gui=NONE
    highlight Underlined gui=underline
    highlight Todo       gui=bold,italic
    highlight Error      gui=reverse
else
    colorscheme default
    highlight Comment    cterm=italic
    highlight Function   cterm=bold,italic
    highlight Keyword    cterm=bold
    highlight Identifier cterm=NONE
    highlight String     cterm=italic
    highlight Constant   cterm=bold
    highlight Statement  cterm=NONE
    highlight PreProc    cterm=bold
    highlight Type       cterm=italic
    highlight Special    cterm=NONE
    highlight Underlined cterm=underline
    highlight Todo       cterm=bold,italic
    highlight Error      cterm=reverse
endif

