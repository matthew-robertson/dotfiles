set nocompatible

" Set up a mapleader other than \
let mapleader = ","

" Set up 4 space tabs
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Encodings
set encoding=utf8
set ffs=unix,dos,mac

" General quality of life stuff
syntax enable
set number
set noruler
set wildmenu
set autoindent
set background=dark
set splitbelow
set splitright

" Navigate splits without ctrl+w first.
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" Only spellcheck markdown files
autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_ca

set showmatch
set mat=2

" search
set ignorecase " Ignore case when searching
set smartcase  " ... Unless I explicitly use caps
set hlsearch

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

" clear highlights with leader+enter
map <silent> <leader><cr> :noh<cr>

" Set up autoclosing brackets
inoremap " ""<left>
inoremap "" ""<left>
inoremap { {}<left>
inoremap {} {}<left>
inoremap ( ()<left>
inoremap () ()<left>
inoremap [ []<left>
inoremap [] []<left>

" Don't clutter my dirs with swp and tmp files
set backupdir=~/.tmp//
set directory=~/.tmp//
