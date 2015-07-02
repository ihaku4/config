if !hasmapto('<Plug>JavaRun')
  map <buffer> <unique> <space> <Plug>JavaRun
endif
noremap <buffer> <unique> <Plug>JavaRun :w \| :!javac -classpath ./:./stdlib.jar:./algs4.jar % && java -ea -classpath ./:./stdlib.jar:./algs4.jar %< 
