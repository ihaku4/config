"setlocal sw= ts= st=
if !hasmapto('<Plug>PythonRun')
  map <buffer> <unique> <space> <Plug>PythonRun
  noremap <buffer> <unique> <Plug>PythonRun :w\|:!python %<cr>
endif
