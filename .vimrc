set nu

set ai
"set smartindent

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set hlsearch
set incsearch

let g:AutoOpenWinManager = 1
nmap <silent> <C-F8> :WMToggle<cr>

set wildmenu
set wildmode=longest:full,full

augroup vimrcEx
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

nmap ,, :w \| !gcc % && ./a.out
nmap ,m :w \| !gcc % && ./a.out<cr>
