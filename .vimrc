" Set up 2 space tabs
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" General quality of life stuff
syntax enable
set number
set wildmenu
set autoindent
set background=dark

" Set up statusline
set laststatus=2
set statusline=
set statusline+=%F

" Use :Bd to close the active buffer without losing the split
command Bd b#<bar>bd #

" Set up autoclosing brackets
inoremap " ""<left>
inoremap "" ""<left>
inoremap ' ''<left>
inoremap '' ''<left>
inoremap { {}<left>
inoremap {} {}<left>
inoremap ( ()<left>
inoremap () ()<left>
inoremap [ []<left>
inoremap [] []<left>
