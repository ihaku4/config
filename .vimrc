set nu
set showtabline=2
"set winheight=20
"set winminheight=5
"set winwidth=80
"set winminwidth=20

set foldmethod=syntax
"nmap zr zR
"nmap zm zM
"set foldtext=MyFoldText()
"function MyFoldText()
"  let line = getline(v:foldstart)
"  let sub = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
"  return v:folddashes . sub
"endfunction
function! NeatFoldText() "{{{2
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()
" }}}2

set ai
"set smartindent

"keep default tabstop=8
"set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set hlsearch
set incsearch

set showcmd

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

"end every cmd with <CR>, or you'll have to type enter by hand.
"and then : is required after every |
nmap \m :w\|!gcc %:p<CR>\|:split %:p.log<cr>\|:%!%:p:h/a.out<cr>\|:w<cr>
nmap \, :w\|!gcc %:p<CR>\|:split %:p.log<cr>\|:%!%:p:h/a.out

nmap \q :close!<cr>

nmap !! :!
nmap <C-Tab> :bn<cr>
nmap <S-Tab> :bp<cr>
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l
nmap <c-\><c-t> :tabe<cr>
nmap <c-\><c-\><c-t> :tabe 
"use <c-o> instead of these imap
"imap <c-e> <esc>A
"imap <c-a> <esc>I
"imap <c-j> <Left>
"imap <c-k> <Right>
nmap / /\v\c
vmap / /\v\c
"cnoremap %s/ %smagic/
"cnoremap \>s/ \>smagic/
"audo fill pwd
"cnoremap %% <C-R>=expand('%:h').'/'<cr>
cnoremap %% <C-R>=expand('%:p:h').'/'<cr>
cnoremap \|\| <space>\| view -

"the two maps blow cause : be slow
"nnoremap :g/ :g/\v
"nnoremap :g// :g//
nmap * *N
nmap \/ :vimgrep /\v\c/gj ./**/*<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
"count search pattern
nmap \\/ :%s//\0/g<cr>
nmap \w :cw<cr>
nmap \\\ :tabe ~/.vimrc<cr>
" this mapping make vi behave awkward when starting
"nnoremap <esc> :noh<return><esc>
nnoremap \<esc> :noh<cr>

nnoremap \cd :cd %:p:h<CR>:pwd<CR>
nnoremap \sh :cd %:p:h<CR>:sh<CR>
nnoremap \tm :cd %:p:h<CR>:!tmux attach \|\| tmux<CR>
nnoremap \\tm :cd %:p:h<CR>:!tmux<CR>
nmap \b :w\|:split %:p.log<CR>\|:%!python %:r<CR>
nmap \d :cd %:p:h<CR>:w\|:!gcc % -g&&gdb -tui ./a.out<cr>
nmap \p :cd %:p:h<CR>:w\|:!gcc %&&./a.out<cr>
nmap \\p :cd %:p:h<CR>:w\|:!gcc %&&./a.out 
"objdump
nmap \\od :cd %:p:h<CR>:w\|:!gcc % -g && objdump -dS a.out
"readelf -a
nmap \\re :cd %:p:h<CR>:w\|:!gcc % -g && readelf -a a.out
"hexdump -C
nmap \\hd :cd %:p:h<CR>:w\|:!gcc % -g && hexdump -C a.out
"gcc -E % | grep typename
"nmap 

nmap \ct :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

nmap gr gT

" auto save & restore session
fu! SaveSess()
  execute 'mksession! ' . $HOME . '/.session.vim'
endfunction

fu! RestoreSess()
if filereadable($HOME . '/.session.vim')
  execute 'so ' . $HOME . '/.session.vim'
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
" this makes a mess when open multiple vi
"autocmd VimEnter * call RestoreSess()

function! s:get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

"vmap \g :%!git show  
nmap \g :tabe<cr>:%!git show 
cmap w!! w !sudo tee >/dev/null %
