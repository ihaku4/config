if !hasmapto('<Plug>MySQLRun')
  map <buffer> <unique> <space> <Plug>MySQLRun
endif
noremap <buffer> <unique> <Plug>MySQLRun :w\|:!mysql -hlocalhost -uroot < %<cr>
