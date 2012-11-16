set nocompatible
set autoindent
set smartindent
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set number
set showcmd
set whichwrap+=h,l
syntax on
set backspace=indent,eol,start

func! CompileC()
    :write
    :!gcc -Wall -O2 -o %< %
endf
func! CompileCPP()
    :write
    :!g++ -Wno-unused-result -Wall -Wextra  -O2 -o %< %
endf
func! CompileTeX()
    :write
    :!pdflatex %
endf
func! AddCFlags(flags)
    :func! CompileC()
        :write
        :+gcc -std=c99 -Wall -O2 a:flags -o %< %
    :endf
endf
func! CompileFlex()
    :write
    :!flex % && g++ -std=c++0x -Wall -O2 lex.yy.c -o %<
endf

func! Run()
    :!./%<
endf
func! RunTeX()
    :!xpdf %<.pdf
endf
func! RunWithArgs()
    :!xargs -L 1 ./%<
endf

autocmd FileType c map <F9> :call CompileC()<Enter>
autocmd FileType c imap <F9> <Esc> :call CompileC()<Enter>
autocmd FileType cpp map <F9> :call CompileCPP()<Enter>
autocmd FileType cpp imap <F9> <Esc> :call CompileCPP()<Enter>
autocmd FileType flex map <F9> :call CompileFlex()<Enter>
autocmd FileType flex imap <F9> <Esc> :call CompileFlex()<Enter>
autocmd FileType tex map <F9> :call CompileTeX()<Enter>
autocmd FileType tex imap <F9> <Esc> :call CompileTeX()<Enter>
map <F5> :call Run()<Enter>
imap <F5> :call Run()<Enter>
autocmd FileType tex map <F5> :call RunTeX()<Enter>
map <F6> :call RunWithArgs()<Enter>
imap <F6> :call RunWithArgs()<Enter>

map <F4> :!bash %<Enter>

imap jj <Esc>
map s :s/

" C // comments
map gc :s:^\([ <Tab>]*\):\1//:<Enter>`'ll
map gu :s:^\([ <Tab>]*\)//:\1:e<Enter>`'hh
set timeoutlen=300

map gz Vj%zf
