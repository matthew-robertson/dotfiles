set nocompatible

" Set up 4 space tabs
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" General quality of life stuff
syntax enable
set number
set noruler
set wildmenu
set autoindent
set background=dark

" Set up statusline, stolen from http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html 
set laststatus=2
set statusline=
set statusline+=%-3.3n\                      " buffer number
set statusline+=%-40f\                      " path
set statusline+=%h%m%r%w                     " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=%10((%l,%c)%)\               " line and column

" Quickly open/save vimrc
nnoremap <leader>ev :split $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Use :Bd to close the active buffer without losing the split
command! Bd b#<bar>bd #

" define :showLongLines command to highlight the offending parts of
" lines that are longer than the specified length (defaulting to 80)
command! -nargs=? ShowLongLines call s:ShowLongLines('<args>')
function! s:ShowLongLines(width)
    let targetWidth = a:width != '' ? a:width : 79
    if targetWidth > 0
        exec 'match Todo /\%>' . (targetWidth) . 'v/'
    else
        echomsg "Usage: HighlightLongLines [natural number]"
    endif
endfunction

" Set up autoclosing brackets
inoremap " ""<left>
inoremap "" ""<left>
inoremap { {}<left>
inoremap {} {}<left>
inoremap ( ()<left>
inoremap () ()<left>
inoremap [ []<left>
inoremap [] []<left>
