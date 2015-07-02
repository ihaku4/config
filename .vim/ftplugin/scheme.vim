if !hasmapto('<Plug>SchemeRun')
  map <buffer> <unique> <space> <Plug>SchemeRun
endif
noremap <buffer> <unique> <Plug>SchemeRun :w <bar> :!scheme < %<cr>
"nmap <space> :w <bar> :!scheme < %<cr>
