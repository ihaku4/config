" ------Vundle Stuff Below
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

"" The following are examples of different formats supported.
"" Keep Plugin commands between vundle#begin/end.
"" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
"" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
"" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
"" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
"" The sparkup vim script is in a subdirectory of this repo called vim.
"" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" Track the engine.
Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsListSnippets="<c-l>" 

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" ------Vundle Stuff End

execute pathogen#infect()
syntax on
"filetype plugin indent on
" filetype plugin on
" [PLUGIN] pydiction config. necessary.
" let g:pydiction_location = '/home/user/.vim/bundle/pydiction/complete-dict'

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

nmap \q :close!<cr>

nmap !! :!
nmap <C-Tab> :bn<cr>
nmap <S-Tab> :bp<cr>
"nmap <C-j> <C-W>j
"nmap <C-k> <C-W>k
"nmap <C-h> <C-W>h
"nmap <C-l> <C-W>l
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

nmap <F8> :NERDTreeToggle<CR>

"" settings for Syntastic (python syntax checker)
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"" let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
let g:syntastic_quiet_messages = { "type": "style" }
let g:syntastic_java_checkers = []
let g:syntastic_python_checkers = []

set pastetoggle=<F7>
set cursorline
hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
set history=1000
nmap \<space> ggVG"+y
