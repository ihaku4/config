set nu

set ai
"set smartindent

"keep default tabstop=8
"set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set hlsearch
set incsearch

let g:AutoOpenWinManager = 1
nmap <silent> <C-F8> :WMToggle<cr>

set wildmenu
set wildmode=longest:full,full

set tags=./tags,tags;

augroup vimrcEx
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

"nmap ,, :w \| !gcc % && ./a.out
"nmap ,m :w \| :vsplit \| .!gcc % && ./a.out<cr>
"nmap ,m :w\|!gcc %<CR>\|:split console\|:r !echo -e "\n-------------------------" && ./a.out<cr>
"nmap ,m :w\|!gcc %<CR>\|:split console\|.!./a.out<cr>

"end every cmd with <CR>, or you'll have to type enter by hand.
"and then : is required after every |
nmap \m :w\|!gcc %:p<CR>\|:split %:p.log<cr>\|:%!%:p:h/a.out<cr>\|:w<cr>
nmap \, :w\|!gcc %:p<CR>\|:split %:p.log<cr>\|:%!%:p:h/a.out
nmap \q :close!<cr>

nmap !! :!
nmap <Tab> :bn<cr>
nmap <S-Tab> :bp<cr>
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

nnoremap \cd :cd %:p:h<CR>:pwd<CR>
nnoremap \sh :sh<CR>
nmap \b :w\|:split %:p.log<CR>\|:%!python %:r<CR>

"map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
nmap \c :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" auto save & restore session
fu! SaveSess()
  execute 'mksession! ' . getcwd() . '/.session.vim'
endfunction

fu! RestoreSess()
if filereadable(getcwd() . '/.session.vim')
  execute 'so ' . getcwd() . '/.session.vim'
  if bufexists(1)
    for l in range(1, bufnr('$'))
      if bufwinnr(l) == -1
        exec 'sbuffer ' . l
      endif
    endfor
  endif
endif
syntax on
endfunction

autocmd VimLeave * call SaveSess()
autocmd VimEnter * call RestoreSess()
